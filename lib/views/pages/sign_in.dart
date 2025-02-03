import 'package:flutter/material.dart';
import 'package:travel_app/cubit/auth_cubit.dart';
import 'package:travel_app/shared/theme.dart';
import 'package:travel_app/views/widgets/custom_button.dart';
import 'package:travel_app/views/widgets/password_text_form_widget.dart';
import 'package:travel_app/views/widgets/text_form_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bgColor,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign In to Begin Your Next Adventure',
                style: primaryTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormWidget(
                        title: 'Email',
                        hintText: 'Email',
                        controller: emailController,
                      ),
                      const SizedBox(height: 20),
                      PasswordTextFormWidget(
                        controller: passwordController,
                      ),
                      const SizedBox(height: 30),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthSuccess) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/main', (route) => false);
                          } else if (state is AuthFailed) {
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
                          if (state is AuthLoading) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: primaryColor,
                            ));
                          }
                          return GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().signIn(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                              }
                            },
                            child: CustomButton(
                              title: 'Sign In',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Center(
                  child: Text('Don’t Have an Account? Sign Up',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                        decoration: TextDecoration.underline,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
