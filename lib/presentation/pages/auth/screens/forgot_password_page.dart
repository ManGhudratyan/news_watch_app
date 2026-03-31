import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_state.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/pages/auth/widgets/auth_layout.dart';
import 'package:news_watch_app/presentation/pages/auth/widgets/reactive_forms_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final FormGroup form = FormGroup(
    {
      'email': FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
      'password': FormControl<String>(
        validators: [Validators.required, Validators.minLength(8)],
      ),
      'confirmPassword': FormControl<String>(validators: [Validators.required]),
    },
    validators: [Validators.mustMatch('password', 'confirmPassword')],
  );

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.error?.isNotEmpty ?? false) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error ?? '')));
          } else if (state.user != null) {
            Navigator.pushNamed(context, RouteConstants.mainPage);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(Gaps.large),
          child: AuthLayout(
            showSocialIcons: false,
            buttonText: AppLocalizations.of(context)!.btnSignIn,
            onPressed: () {
              if (form.valid) {
                final email = form.control('email').value as String;
                final newPassword = form.control('password').value as String;
                context.read<AuthCubit>().resetPassword(email, newPassword);
              } else {
                form.markAllAsTouched();
              }
            },
            form: ReactiveForm(
              formGroup: form,
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.03),
                  ReactiveFormsWidget(
                    title: AppLocalizations.of(context)!.txtEnterYourEmail,
                    formControl: form.control('email') as FormControl<String>,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  ReactiveFormsWidget(
                    title: AppLocalizations.of(context)!.txtEnterNewPassword,
                    formControl:
                        form.control('password') as FormControl<String>,
                    obscureText: true,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  ReactiveFormsWidget(
                    title: AppLocalizations.of(context)!.txtReEnterYourPassword,
                    formControl:
                        form.control('confirmPassword') as FormControl<String>,
                    obscureText: true,
                  ),
                  ReactiveFormConsumer(
                    builder: (context, formGroup, child) {
                      if (formGroup.hasError('mustMatch')) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            AppLocalizations.of(
                              context,
                            )!.txtPasswordsDoNotMatch,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
