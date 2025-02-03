import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/cubit/auth_cubit.dart';
import 'package:travel_app/cubit/destination_cubit.dart';
import 'package:travel_app/cubit/new_destination_cubit.dart';
import 'package:travel_app/cubit/page_cubit.dart';
import 'package:travel_app/cubit/seat_cubit.dart';
import 'package:travel_app/cubit/transaction_cubit.dart';
import 'package:travel_app/models/destination_model.dart';
import 'package:travel_app/models/transaction_model.dart';
import 'package:travel_app/models/user_model.dart';
import 'package:travel_app/views/pages/change_profile_screen.dart';
import 'package:travel_app/views/pages/main_screen.dart';
import 'package:travel_app/views/pages/splashScreen.dart';
import 'package:travel_app/views/pages/onboarding_screen.dart';
import 'package:travel_app/views/pages/sign_up.dart';
import 'package:travel_app/views/pages/sign_in.dart';
import 'package:travel_app/views/pages/bonus_saldo_screen.dart';
import 'package:travel_app/views/widgets/route_transition.dart';
import 'package:travel_app/views/pages/detail_destination_screen.dart';
import 'package:travel_app/views/pages/choose_seat_screen.dart';
import 'package:travel_app/views/pages/checkout_screen.dart';
import 'package:travel_app/views/pages/success_checkout_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PageCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => DestinationCubit()),
        BlocProvider(create: (context) => NewDestinationCubit()),
        BlocProvider(create: (context) => SeatCubit()),
        BlocProvider(create: (context) => TransactionCubit()),
      ],
      child: MaterialApp(
        title: 'Travel App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/signup':
              return RouteTransition.easeIn(child: SignUpScreen());
            case '/signin':
              return RouteTransition.easeIn(child: SignInScreen());
            case '/onboarding':
              return RouteTransition.fadeIn(child: OnboardingScreen());
            case '/bonus':
              return RouteTransition.easeIn(
                  child:
                      BonusSaldoScreen(user: settings.arguments as UserModel));
            case '/main':
              return RouteTransition.fadeIn(child: MainScreen());
            case '/detail':
              return RouteTransition.easeIn(
                  child: DetailDestinationScreen(
                      destination: settings.arguments as DestinationModel));
            case '/seat':
              return RouteTransition.easeIn(
                  child: ChooseSeatScreen(
                destination: settings.arguments as DestinationModel,
              ));
            case '/checkout':
              return RouteTransition.easeIn(
                  child: CheckoutScreen(
                transaction: settings.arguments as TransactionModel,
              ));
            case '/success':
              return RouteTransition.fadeIn(child: SuccessCheckoutScreen());
            case '/changeProfile':
              return RouteTransition.easeIn(
                  child: ChangeProfileScreen(
                user: settings.arguments as UserModel,
              ));
            default:
              return RouteTransition.easeIn(child: Splashscreen());
          }
        },
      ),
    );
  }
}
