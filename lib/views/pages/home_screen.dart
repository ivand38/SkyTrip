import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/cubit/auth_cubit.dart';
import 'package:travel_app/cubit/destination_cubit.dart';
import 'package:travel_app/cubit/new_destination_cubit.dart';
import 'package:travel_app/models/destination_model.dart';
import 'package:travel_app/services/user_service.dart';
import 'package:travel_app/shared/theme.dart';
import 'package:travel_app/views/widgets/custom_big_card.dart';
import 'package:travel_app/views/widgets/new_destination_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<DestinationCubit>().fetchDestination();
    context.read<NewDestinationCubit>().fetchNewDestination();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, \n${state.user.name}',
                      style: primaryTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      'Where to fly today?',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    )
                  ],
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      CachedNetworkImageProvider(state.user.profilePic),
                )
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      );
    }

    Widget popularDestination(List<DestinationModel> destinations) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: destinations.map((DestinationModel destination) {
            return CustomBigCard(destination);
          }).toList(),
        ),
      );
    }

    Widget newDestination(List<DestinationModel> newDestinations) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: newDestinations.map((DestinationModel newDestination) {
          return NewDestinationCard(newDestination);
        }).toList(),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: BlocConsumer<DestinationCubit, DestinationState>(
          listener: (context, state) {
            if (state is DestinationFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  elevation: 4.0,
                  behavior: SnackBarBehavior.floating,
                  content: Text(state.error),
                  backgroundColor: redColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is DestinationSuccess) {
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        header(),
                        const SizedBox(height: 30),
                        popularDestination(state.destinations),
                        const SizedBox(height: 30),
                        Text(
                          'New Destination',
                          style: primaryTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<NewDestinationCubit, NewDestinationState>(
                          builder: (context, newState) {
                            if (newState is NewDestinationSuccess) {
                              return newDestination(newState.newDestinations);
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ));
            }

            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
