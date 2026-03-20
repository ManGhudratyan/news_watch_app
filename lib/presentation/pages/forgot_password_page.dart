import 'package:flutter/material.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/widgets/auth_layout.dart';
import 'package:news_watch_app/presentation/widgets/form_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Gaps.large),
        child: AuthLayout(
          form: Column(
            children: [
              SizedBox(height: screenHeight * 0.03),
              FormWidget(
                controller: emailController,
                labelText: AppLocalizations.of(context)!.txtEnterYourEmail,
              ),
              SizedBox(height: screenHeight * 0.03),
              FormWidget(
                controller: codeController,
                labelText: AppLocalizations.of(context)!.txtVerificationCode,
              ),
              SizedBox(height: screenHeight * 0.03),
              FormWidget(
                controller: passwordController,
                labelText: AppLocalizations.of(context)!.txtEnterNewPassword,
                obscureText: true,
              ),
              SizedBox(height: screenHeight * 0.03),
              FormWidget(
                controller: repeatPasswordController,
                labelText: AppLocalizations.of(context)!.txtReEnterYourPassword,
                obscureText: true,
              ),
              SizedBox(height: screenHeight * 0.09),
            ],
          ),
          buttonText: AppLocalizations.of(context)!.btnSignIn,
          onPressed: () {
            final password = passwordController.text.trim();
            final repeatPassword = repeatPasswordController.text.trim();
            if (password.isEmpty || repeatPassword.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(context)!.txtPleaseFillAllFields,
                  ),
                ),
              );
              return;
            }
            if (password != repeatPassword) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(context)!.txtPasswordsDoNotMatch,
                  ),
                ),
              );
              return;
            }
            Navigator.pushReplacementNamed(context, RouteConstants.homePage);
          },
          showSocialIcons: false,
        ),
      ),
    );
  }
}
