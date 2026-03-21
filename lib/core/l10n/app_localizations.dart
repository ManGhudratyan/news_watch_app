import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('am'),
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @btnSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get btnSignUp;

  /// No description provided for @btnSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get btnSignIn;

  /// No description provided for @txtUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get txtUsername;

  /// No description provided for @txtEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get txtEmail;

  /// No description provided for @txtPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get txtPhoneNumber;

  /// No description provided for @txtPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get txtPassword;

  /// No description provided for @txtRepeatPassword.
  ///
  /// In en, this message translates to:
  /// **'Repeat password'**
  String get txtRepeatPassword;

  /// No description provided for @txtMediaReporter.
  ///
  /// In en, this message translates to:
  /// **'Media Reporter'**
  String get txtMediaReporter;

  /// No description provided for @txtVisitor.
  ///
  /// In en, this message translates to:
  /// **'Visitor'**
  String get txtVisitor;

  /// No description provided for @txtHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Have an account?'**
  String get txtHaveAnAccount;

  /// No description provided for @txtIamA.
  ///
  /// In en, this message translates to:
  /// **'I am a'**
  String get txtIamA;

  /// No description provided for @txtForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get txtForgotPassword;

  /// No description provided for @txtDontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Dont have an account?'**
  String get txtDontHaveAnAccount;

  /// No description provided for @txtRegister.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get txtRegister;

  /// No description provided for @txtEnterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get txtEnterYourEmail;

  /// No description provided for @txtVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get txtVerificationCode;

  /// No description provided for @txtEnterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get txtEnterNewPassword;

  /// No description provided for @txtReEnterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Re Enter your Password'**
  String get txtReEnterYourPassword;

  /// No description provided for @txtPleaseFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get txtPleaseFillAllFields;

  /// No description provided for @txtPasswordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get txtPasswordsDoNotMatch;

  /// No description provided for @txtOrSignInWith.
  ///
  /// In en, this message translates to:
  /// **'or sign in with'**
  String get txtOrSignInWith;

  /// No description provided for @txtAppBarSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get txtAppBarSettings;

  /// No description provided for @txtProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get txtProfile;

  /// No description provided for @txtMyWallet.
  ///
  /// In en, this message translates to:
  /// **'My Wallet'**
  String get txtMyWallet;

  /// No description provided for @txtMyPost.
  ///
  /// In en, this message translates to:
  /// **'My Post'**
  String get txtMyPost;

  /// No description provided for @txtBoostYourPost.
  ///
  /// In en, this message translates to:
  /// **'Boost Your Post'**
  String get txtBoostYourPost;

  /// No description provided for @txtNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get txtNotifications;

  /// No description provided for @txtTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get txtTermsAndConditions;

  /// No description provided for @txtAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get txtAbout;

  /// No description provided for @txtWatchAdsAndEarn.
  ///
  /// In en, this message translates to:
  /// **'Watch Ads & Earn'**
  String get txtWatchAdsAndEarn;

  /// No description provided for @txtReferAndEarn.
  ///
  /// In en, this message translates to:
  /// **'Refer and Earn'**
  String get txtReferAndEarn;

  /// No description provided for @txtLogOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get txtLogOut;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['am', 'en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am':
      return AppLocalizationsAm();
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
