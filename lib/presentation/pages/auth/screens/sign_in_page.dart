import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/pages/auth/logic/user_bloc.dart';
import 'package:news_watch_app/presentation/pages/auth/widgets/auth_layout.dart';
import 'package:news_watch_app/presentation/pages/auth/widgets/reactive_forms_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FormGroup form = FormGroup({
    'username': FormControl<String>(validators: [Validators.required]),
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(8)],
    ),
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final txt = AppLocalizations.of(context)!;

    return BlocConsumer<UserBloc, UserState>(
      listener: (context, userState) {
        if (userState is UserError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(userState.message)));
        }
        if (userState is UserLoaded) {
          final savedUser = userState.user;
          final enteredEmail = form.control('email').value;
          final enteredPassword = form.control('password').value;

          if (savedUser.email == enteredEmail &&
              savedUser.password == enteredPassword) {
            Navigator.pushReplacementNamed(context, RouteConstants.mainPage);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Please write right data",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        }
      },
      builder: (context, userState) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Gaps.large),
            child: AuthLayout(
              buttonText: txt.btnSignIn,
              onPressed: () {
                if (form.valid) {
                  context.read<UserBloc>().add(GetUserEvent());
                } else {
                  form.markAllAsTouched();
                }
              },
              form: ReactiveForm(
                formGroup: form,
                child: Column(
                  children: [
                    ReactiveFormsWidget(
                      title: txt.txtUsername,
                      formControl:
                          form.control('username') as FormControl<String>,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    ReactiveFormsWidget(
                      title: txt.txtEmail,
                      formControl: form.control('email') as FormControl<String>,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    ReactiveFormsWidget(
                      title: txt.txtPassword,
                      formControl:
                          form.control('password') as FormControl<String>,
                      obscureText: true,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteConstants.forgotPasswordPage,
                        );
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(txt.txtForgotPassword),
                      ),
                    ),
                  ],
                ),
              ),
              endingText: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(txt.txtDontHaveAnAccount),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteConstants.signUpPage);
                    },
                    child: Text(
                      txt.txtRegister,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
