import 'package:flutter/material.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/presentation/constants/assets.dart';
import 'package:news_watch_app/presentation/constants/constants.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/widgets/button_widget.dart';
import 'package:news_watch_app/presentation/widgets/divider_with_text.dart';
import 'package:news_watch_app/presentation/widgets/icons_container.dart';

class AuthLayout extends StatelessWidget {
  final Widget form;
  final String buttonText;
  final Widget? endingText;
  final VoidCallback onPressed;
  final bool showSocialIcons;
  final bool showEndingText;

  const AuthLayout({
    super.key,
    required this.form,
    required this.buttonText,
    required this.onPressed,
    this.endingText,
    this.showSocialIcons = true,
    this.showEndingText = true,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Gaps.larger),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Assets.newsWatch,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              SizedBox(height: screenHeight * 0.02),
              form,
              SizedBox(height: screenHeight * 0.03),
              SizedBox(
                width: double.infinity,
                child: ButtonWidget(title: buttonText, onPressed: onPressed),
              ),
              SizedBox(height: screenHeight * 0.02),
              if (showSocialIcons) ...[
                DividerWithText(
                  text: AppLocalizations.of(context)!.txtOrSignInWith,
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconsContainer(icon: Assets.emailLogo),
                    SizedBox(width: Constants.sizedBoxWidth),
                    IconsContainer(icon: Assets.googleLogo),
                    SizedBox(width: Constants.sizedBoxWidth),
                    IconsContainer(icon: Assets.facebookLogo),
                    SizedBox(width: Constants.sizedBoxWidth),
                    IconsContainer(icon: Assets.twitterLogo),
                  ],
                ),
              ],
              if (showEndingText && endingText != null) ...[
                SizedBox(height: screenHeight * 0.03),
                endingText!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
