import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/cubit/auth_cubit.dart';
import 'package:travel_app/cubit/page_cubit.dart';
import 'package:travel_app/shared/theme.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: bgColor,
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthSuccess) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(17),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: CachedNetworkImageProvider(
                                        state.user.profilePic),
                                  ),
                                  const SizedBox(height: 20),
                                  Text('${state.user.name}',
                                      style: primaryTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: semiBold,
                                      )),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Hobby: ${state.user.hobby}',
                                    style: secondaryTextStyle.copyWith(
                                        fontSize: 14, fontWeight: medium),
                                  ),
                                  const SizedBox(height: 30),
                                  Divider(
                                    color: strokeColor,
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/changeProfile',
                                          arguments: state.user);
                                    },
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            color: blackColor,
                                          ),
                                          const SizedBox(width: 6),
                                          Text('Change Profile',
                                              style: primaryTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: regular,
                                              )),
                                        ]),
                                  ),
                                  const SizedBox(height: 20),
                                  BlocConsumer<AuthCubit, AuthState>(
                                    listener: (context, state) {
                                      if (state is AuthFailed) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            elevation: 4.0,
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(state.error),
                                            backgroundColor: redColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                        );
                                      } else if (state is AuthInitial) {
                                        context.read<PageCubit>().setPage(0);
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is AuthLoading) {
                                        return Center(
                                            child: CircularProgressIndicator(
                                          color: primaryColor,
                                        ));
                                      }
                                      return GestureDetector(
                                        onTap: () {
                                          context.read<AuthCubit>().signOut();
                                          context.read<PageCubit>().setPage(0);
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/signin',
                                              (route) => false);
                                        },
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.output,
                                                color: redColor,
                                              ),
                                              const SizedBox(width: 6),
                                              Text('Log Out',
                                                  style: redTextStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: regular,
                                                  )),
                                            ]),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          )
                        ]);
                  } else {
                    return SizedBox();
                  }
                },
              ),
            )));
  }
}
