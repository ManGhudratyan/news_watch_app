// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_state.dart';
import 'package:news_watch_app/data/models/user/user_model.dart';
import 'package:news_watch_app/presentation/constants/constants.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/pages/auth/widgets/auth_layout.dart';
import 'package:news_watch_app/core/enums/radio_type.dart';
import 'package:news_watch_app/presentation/pages/auth/widgets/reactive_forms_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  RadioType selectedValue = RadioType.mediaReporter;
  final FormGroup form = FormGroup({
    'username': FormControl<String>(validators: [Validators.required]),
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'phone': FormControl<String>(
      validators: [Validators.required, Validators.pattern(r'^\+?\d+$')],
    ),
    'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(8)],
    ),
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final txt = AppLocalizations.of(context)!;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, authState) {
        if (authState.error?.isNotEmpty ?? false) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(authState.error ?? '')));
        }
        if (authState.user != null) {
          Navigator.pushReplacementNamed(context, RouteConstants.mainPage);
        }
      },
      builder: (context, authState) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Gaps.large),
            child: AuthLayout(
              buttonText: txt.btnSignUp,
              onPressed: () {
                if (form.valid) {
                  final user = UserModel(
                    username: form.control('username').value,
                    email: form.control('email').value,
                    phoneNumber: form.control('phone').value,
                    radioType: selectedValue,
                    password: form.control('password').value,
                    userId: null,
                  );

                  context.read<AuthCubit>().addUser(user);
                } else {
                  form.markAllAsTouched();
                }
              },
              form: Column(
                children: [
                  ReactiveForm(
                    formGroup: form,
                    child: Column(
                      children: [
                        ReactiveFormsWidget(
                          title: txt.txtUsername,
                          formControl:
                              form.control('username') as FormControl<String>,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        ReactiveFormsWidget(
                          title: txt.txtEmail,
                          formControl:
                              form.control('email') as FormControl<String>,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        ReactiveFormsWidget(
                          title: txt.txtPhoneNumber,
                          formControl:
                              form.control('phone') as FormControl<String>,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\+?\d*'),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        ReactiveFormsWidget(
                          title: txt.txtPassword,
                          formControl:
                              form.control('password') as FormControl<String>,
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.topLeft,
                    child: Text(txt.txtIamA),
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
                          Text(txt.txtMediaReporter),
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
                          Text(txt.txtVisitor),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              endingText: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(txt.txtHaveAnAccount),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteConstants.signInPage);
                    },
                    child: Text(
                      txt.btnSignIn,
                      style: TextStyle(fontWeight: FontWeight.bold),
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
