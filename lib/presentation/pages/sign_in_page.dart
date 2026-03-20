import 'package:flutter/material.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/widgets/auth_layout.dart';
import 'package:news_watch_app/presentation/widgets/form_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Gaps.large),
        child: AuthLayout(
          buttonText: AppLocalizations.of(context)!.btnSignIn,
          onPressed: () {},
          form: Column(
            children: [
              FormWidget(
                controller: usernameController,
                labelText: AppLocalizations.of(context)!.txtUsername,
              ),
              SizedBox(height: screenHeight * 0.03),
              FormWidget(
                controller: emailController,
                labelText: AppLocalizations.of(context)!.txtEmail,
              ),
              SizedBox(height: screenHeight * 0.03),
              FormWidget(
                controller: passwordController,
                labelText: AppLocalizations.of(context)!.txtPassword,
                obscureText: true,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    RouteConstants.forgotPasswordPage,
                  );
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(AppLocalizations.of(context)!.txtForgotPassword),
                ),
              ),
            ],
          ),
          endingText: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.txtDontHaveAnAccount),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    RouteConstants.signUpPage,
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.txtRegister,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
