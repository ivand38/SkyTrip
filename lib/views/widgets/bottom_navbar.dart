import 'package:flutter/material.dart';
import 'package:travel_app/cubit/page_cubit.dart';
import 'package:travel_app/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return BottomNavigationBar(
      elevation: 0,
      backgroundColor: whiteColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: greyColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: context.watch<PageCubit>().state,
      onTap: (value) {
        index = value;
        context.read<PageCubit>().setPage(value);
      },
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.language),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.receipt_long,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.credit_card_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
      ],
    );
  }
}
