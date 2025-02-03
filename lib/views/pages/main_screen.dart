import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/cubit/page_cubit.dart';
import 'package:travel_app/views/pages/home_screen.dart';
import 'package:travel_app/views/pages/transaction_list_screen.dart';
import 'package:travel_app/views/pages/wallet_screen.dart';
import 'package:travel_app/views/pages/setting_screen.dart';
import 'package:travel_app/views/widgets/bottom_navbar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget bodyPage(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return HomeScreen();
        case 1:
          return TransactionListScreen();
        case 2:
          return WalletScreen();
        case 3:
          return SettingScreen();
        default:
          return HomeScreen();
      }
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, currentIndex) {
        return SafeArea(
            child: Scaffold(
          extendBody: true,
          bottomNavigationBar: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
              ),
              child: BottomNavbar()),
          body: bodyPage(currentIndex),
        ));
      },
    );
  }
}
