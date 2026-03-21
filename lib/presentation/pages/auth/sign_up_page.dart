// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/presentation/constants/constants.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/widgets/form_widget.dart';
import 'package:news_watch_app/presentation/widgets/auth_layout.dart';
import 'package:news_watch_app/core/enums/radio_type.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  RadioType selectedValue = RadioType.mediaReporter;

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Gaps.large),
        child: AuthLayout(
          buttonText: AppLocalizations.of(context)!.btnSignUp,
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
                // !use reactive_forms: ^18.2.2
              ),
              SizedBox(height: screenHeight * 0.03),
              FormWidget(
                controller: phoneController,
                labelText: AppLocalizations.of(context)!.txtPhoneNumber,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\+?\d*')),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              FormWidget(
                controller: passwordController,
                labelText: AppLocalizations.of(context)!.txtPassword,
                obscureText: true,
              ),
              SizedBox(height: Constants.sizedBoxWidth),
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: Text(AppLocalizations.of(context)!.txtIamA),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio<RadioType>(
                        value: RadioType.mediaReporter,
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                      Text(AppLocalizations.of(context)!.txtMediaReporter),
                    ],
                  ),
                  SizedBox(width: Constants.sizedBoxWidth),
                  Row(
                    children: [
                      Radio<RadioType>(
                        value: RadioType.visitor,
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                      Text(AppLocalizations.of(context)!.txtVisitor),
                    ],
                  ),
                ],
              ),
            ],
          ),
          endingText: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.txtHaveAnAccount),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteConstants.signInPage);
                },
                child: Text(
                  AppLocalizations.of(context)!.btnSignIn,
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
