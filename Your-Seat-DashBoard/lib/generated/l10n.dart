// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `zakaria`
  String get zakaria {
    return Intl.message(
      'zakaria',
      name: 'zakaria',
      desc: '',
      args: [],
    );
  }

  /// `No notifications yet`
  String get noNotificationsYet {
    return Intl.message(
      'No notifications yet',
      name: 'noNotificationsYet',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get user_not_found {
    return Intl.message(
      'User not found',
      name: 'user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Password updated successfully`
  String get password_updated_successfully {
    return Intl.message(
      'Password updated successfully',
      name: 'password_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signin {
    return Intl.message(
      'Sign In',
      name: 'signin',
      desc: '',
      args: [],
    );
  }

  /// `At YourSeat, we are committed to protecting your privacy. This privacy policy explains how we collect, use, and safeguard your personal data when you use the YourSeat mobile application. By using the app, you agree to the collection and use of your information in accordance with this policy.\n\n1. How We Use Your Information: The information we collect from you is used for the following purposes:\n   To provide and maintain the app: Ensuring the app functions properly and improving its performance.\n   To process transactions: Managing payments for movie tickets and related services.\n   To offer personalized recommendations: Suggesting movies and cinemas based on your preferences and location.\n   To communicate with you: Sending notifications about your bookings, promotions, or updates to our services.\n   To improve our services: Analyzing app usage data to enhance features and resolve issues.\n\n2. How We Protect Your Data: YourSeat employs standard security measures to protect your personal information, including:\n   Encryption: Securing your payment data and personal information using encryption protocols like SSL.\n   Access restrictions: Ensuring only authorized personnel can access your personal data.\n   Continuous audits: Regularly reviewing our security practices to ensure your data’s safety.\n   While we take all precautions, no security measures are completely foolproof, and we cannot guarantee the absolute security of your data.\n\n3. Data Sharing and Disclosure: YourSeat does not sell or share your personal information with third parties, except:\n   Service Providers: We work with trusted third-party partners (e.g., payment processors, cloud storage providers) to help deliver our services.\n   Legal Obligations: We may disclose your information if required by law or in response to a valid legal request (e.g., a court order).\n\n4. Your Rights: You have the following rights regarding your personal data:\n   Access: You can request a copy of the personal data we hold about you.\n   Correction: You can request corrections or updates to your data.\n   Deletion: You can request deletion of your data, subject to legal requirements.\n   Opt-out of marketing: You can opt-out of promotional communications by following the unsubscribe link in our emails or adjusting app settings.`
  String get privacyPolicyContent {
    return Intl.message(
      'At YourSeat, we are committed to protecting your privacy. This privacy policy explains how we collect, use, and safeguard your personal data when you use the YourSeat mobile application. By using the app, you agree to the collection and use of your information in accordance with this policy.\n\n1. How We Use Your Information: The information we collect from you is used for the following purposes:\n   To provide and maintain the app: Ensuring the app functions properly and improving its performance.\n   To process transactions: Managing payments for movie tickets and related services.\n   To offer personalized recommendations: Suggesting movies and cinemas based on your preferences and location.\n   To communicate with you: Sending notifications about your bookings, promotions, or updates to our services.\n   To improve our services: Analyzing app usage data to enhance features and resolve issues.\n\n2. How We Protect Your Data: YourSeat employs standard security measures to protect your personal information, including:\n   Encryption: Securing your payment data and personal information using encryption protocols like SSL.\n   Access restrictions: Ensuring only authorized personnel can access your personal data.\n   Continuous audits: Regularly reviewing our security practices to ensure your data’s safety.\n   While we take all precautions, no security measures are completely foolproof, and we cannot guarantee the absolute security of your data.\n\n3. Data Sharing and Disclosure: YourSeat does not sell or share your personal information with third parties, except:\n   Service Providers: We work with trusted third-party partners (e.g., payment processors, cloud storage providers) to help deliver our services.\n   Legal Obligations: We may disclose your information if required by law or in response to a valid legal request (e.g., a court order).\n\n4. Your Rights: You have the following rights regarding your personal data:\n   Access: You can request a copy of the personal data we hold about you.\n   Correction: You can request corrections or updates to your data.\n   Deletion: You can request deletion of your data, subject to legal requirements.\n   Opt-out of marketing: You can opt-out of promotional communications by following the unsubscribe link in our emails or adjusting app settings.',
      name: 'privacyPolicyContent',
      desc: '',
      args: [],
    );
  }

  /// `1. User Responsibilities: By using this app, you agree to comply with our terms of service and act respectfully. Please refrain from any behavior that disrupts the movie-watching experience for others, such as loud talking, using your EmailAddress, or purchasing tickets for unauthorized use. We reserve the right to revoke access to the app if these terms are violated.\n\n2. Creating a User Account: To create an account, you’ll need to provide a valid email address and a strong password. Choose a password that’s hard to guess and avoid using easily identifiable information. Your account data is stored securely and is accessible only to authorized personnel. Security: Choose a strong password combining letters, numbers, and symbols. Avoid using the same password for multiple accounts. Enable two-factor authentication (if available) for added security. Do not share your login information with anyone.\n\n3. Transaction Processing: All transactions are processed securely using [specify payment gateway]. We accept [list accepted payment methods, such as credit cards, debit cards, PayPal]. Additional Information: Ensure your payment information is accurate and up-to-date. We reserve the right to cancel orders in cases of fraudulent activity or incorrect payment information. For any questions or concerns regarding payments, please contact our customer support team.\n\n4. Content Ownership: All content within the app, including images, text, videos, and other materials, is owned by [Your Seat] or its licensors. Unless otherwise indicated, you are not permitted to use, reproduce, modify, distribute, or display any content from the app without prior written permission.`
  String get termsAndConditionsContent {
    return Intl.message(
      '1. User Responsibilities: By using this app, you agree to comply with our terms of service and act respectfully. Please refrain from any behavior that disrupts the movie-watching experience for others, such as loud talking, using your EmailAddress, or purchasing tickets for unauthorized use. We reserve the right to revoke access to the app if these terms are violated.\n\n2. Creating a User Account: To create an account, you’ll need to provide a valid email address and a strong password. Choose a password that’s hard to guess and avoid using easily identifiable information. Your account data is stored securely and is accessible only to authorized personnel. Security: Choose a strong password combining letters, numbers, and symbols. Avoid using the same password for multiple accounts. Enable two-factor authentication (if available) for added security. Do not share your login information with anyone.\n\n3. Transaction Processing: All transactions are processed securely using [specify payment gateway]. We accept [list accepted payment methods, such as credit cards, debit cards, PayPal]. Additional Information: Ensure your payment information is accurate and up-to-date. We reserve the right to cancel orders in cases of fraudulent activity or incorrect payment information. For any questions or concerns regarding payments, please contact our customer support team.\n\n4. Content Ownership: All content within the app, including images, text, videos, and other materials, is owned by [Your Seat] or its licensors. Unless otherwise indicated, you are not permitted to use, reproduce, modify, distribute, or display any content from the app without prior written permission.',
      name: 'termsAndConditionsContent',
      desc: '',
      args: [],
    );
  }

  /// `We would love to hear from you! Whether you have inquiries, need support, want to share feedback, or simply have suggestions, our team is here to help. Please do not hesitate to reach out to us using the form below or through the contact details provided.\nContact \nFeedback and Suggestions:\nWe greatly value your input! If you have any suggestions on how to improve your experience with YourSeat, please share them in the message field of the contact form or send them directly to our email.\n\nConnect with us on our social media channels for the latest updates, promotions, and more:`
  String get contactUsContent {
    return Intl.message(
      'We would love to hear from you! Whether you have inquiries, need support, want to share feedback, or simply have suggestions, our team is here to help. Please do not hesitate to reach out to us using the form below or through the contact details provided.\nContact \nFeedback and Suggestions:\nWe greatly value your input! If you have any suggestions on how to improve your experience with YourSeat, please share them in the message field of the contact form or send them directly to our email.\n\nConnect with us on our social media channels for the latest updates, promotions, and more:',
      name: 'contactUsContent',
      desc: '',
      args: [],
    );
  }

  /// `contact Us`
  String get contactUs {
    return Intl.message(
      'contact Us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in the credentials.`
  String get pleaseFillTheCredentials {
    return Intl.message(
      'Please fill in the credentials.',
      name: 'pleaseFillTheCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Facebook`
  String get continueWithFacebook {
    return Intl.message(
      'Continue with Facebook',
      name: 'continueWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get continueWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'continueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Continue as Guest`
  String get continueAsGuest {
    return Intl.message(
      'Continue as Guest',
      name: 'continueAsGuest',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account yet?`
  String get dontHaveAnyAccountYet {
    return Intl.message(
      'Don’t have an account yet?',
      name: 'dontHaveAnyAccountYet',
      desc: '',
      args: [],
    );
  }

  /// `Confirm OTP Code`
  String get confirmOtpCode {
    return Intl.message(
      'Confirm OTP Code',
      name: 'confirmOtpCode',
      desc: '',
      args: [],
    );
  }

  /// `You just need to enter the OTP sent to the registered Email Address.`
  String get youJustNeedToEnterTheOtpSentToTheRegisteredEmailAddress {
    return Intl.message(
      'You just need to enter the OTP sent to the registered Email Address.',
      name: 'youJustNeedToEnterTheOtpSentToTheRegisteredEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continuee {
    return Intl.message(
      'Continue',
      name: 'continuee',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Birth Date`
  String get birthDate {
    return Intl.message(
      'Birth Date',
      name: 'birthDate',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `I agree with the`
  String get iAgreeWith {
    return Intl.message(
      'I agree with the',
      name: 'iAgreeWith',
      desc: '',
      args: [],
    );
  }

  /// `PrivacyPolicy`
  String get privacyPolicy {
    return Intl.message(
      'PrivacyPolicy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Promotions & Discounts`
  String get promoDiscount {
    return Intl.message(
      'Promotions & Discounts',
      name: 'promoDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Cinema`
  String get cinema {
    return Intl.message(
      'Cinema',
      name: 'cinema',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `My Ticket`
  String get myTicket {
    return Intl.message(
      'My Ticket',
      name: 'myTicket',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all fields`
  String get fill_all_fields {
    return Intl.message(
      'Please fill all fields',
      name: 'fill_all_fields',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your Email Address`
  String get please_enter_EmailAddress {
    return Intl.message(
      'Please enter your Email Address',
      name: 'please_enter_EmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Email Address format`
  String get wrong_EmailAddress_format {
    return Intl.message(
      'Wrong Email Address format',
      name: 'wrong_EmailAddress_format',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get please_enter_password {
    return Intl.message(
      'Please enter your password',
      name: 'please_enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 \n characters long, uppercase letter, \nnumber, special character.`
  String get password_requirements {
    return Intl.message(
      'Password must be at least 8 \n characters long, uppercase letter, \nnumber, special character.',
      name: 'password_requirements',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters.`
  String get password_min_length {
    return Intl.message(
      'Password must be at least 6 characters.',
      name: 'password_min_length',
      desc: '',
      args: [],
    );
  }

  /// `Password is wrong`
  String get wrong_password {
    return Intl.message(
      'Password is wrong',
      name: 'wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `Email Address does not exist`
  String get EmailAddress_does_not_exist {
    return Intl.message(
      'Email Address does not exist',
      name: 'EmailAddress_does_not_exist',
      desc: '',
      args: [],
    );
  }

  /// `Failed to log in with Facebook`
  String get facebook_login_failed {
    return Intl.message(
      'Failed to log in with Facebook',
      name: 'facebook_login_failed',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred during login`
  String get login_error {
    return Intl.message(
      'An error occurred during login',
      name: 'login_error',
      desc: '',
      args: [],
    );
  }

  /// `Login successful`
  String get login_successful {
    return Intl.message(
      'Login successful',
      name: 'login_successful',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred during login`
  String get error_during_login {
    return Intl.message(
      'An error occurred during login',
      name: 'error_during_login',
      desc: '',
      args: [],
    );
  }

  /// `Registration successful!`
  String get registerSuccess {
    return Intl.message(
      'Registration successful!',
      name: 'registerSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Error saving user data.`
  String get errorSavingUser {
    return Intl.message(
      'Error saving user data.',
      name: 'errorSavingUser',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? Sign In`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account? Sign In',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Jan`
  String get january {
    return Intl.message(
      'Jan',
      name: 'january',
      desc: '',
      args: [],
    );
  }

  /// `Feb`
  String get february {
    return Intl.message(
      'Feb',
      name: 'february',
      desc: '',
      args: [],
    );
  }

  /// `March`
  String get march {
    return Intl.message(
      'March',
      name: 'march',
      desc: '',
      args: [],
    );
  }

  /// `April`
  String get april {
    return Intl.message(
      'April',
      name: 'april',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get may {
    return Intl.message(
      'May',
      name: 'may',
      desc: '',
      args: [],
    );
  }

  /// `June`
  String get june {
    return Intl.message(
      'June',
      name: 'june',
      desc: '',
      args: [],
    );
  }

  /// `July`
  String get july {
    return Intl.message(
      'July',
      name: 'july',
      desc: '',
      args: [],
    );
  }

  /// `Aug`
  String get august {
    return Intl.message(
      'Aug',
      name: 'august',
      desc: '',
      args: [],
    );
  }

  /// `Sep`
  String get september {
    return Intl.message(
      'Sep',
      name: 'september',
      desc: '',
      args: [],
    );
  }

  /// `Oct`
  String get october {
    return Intl.message(
      'Oct',
      name: 'october',
      desc: '',
      args: [],
    );
  }

  /// `Nove`
  String get november {
    return Intl.message(
      'Nove',
      name: 'november',
      desc: '',
      args: [],
    );
  }

  /// `Dec`
  String get december {
    return Intl.message(
      'Dec',
      name: 'december',
      desc: '',
      args: [],
    );
  }

  /// `Invalid username`
  String get invalidUsername {
    return Intl.message(
      'Invalid username',
      name: 'invalidUsername',
      desc: '',
      args: [],
    );
  }

  /// `You must accept the terms and conditions.`
  String get pleaseAcceptPrivacyAndPolicy {
    return Intl.message(
      'You must accept the terms and conditions.',
      name: 'pleaseAcceptPrivacyAndPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get sign_in {
    return Intl.message(
      'Sign In',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Email Address `
  String get enter_EmailAddress {
    return Intl.message(
      'Enter your Email Address ',
      name: 'enter_EmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Email Address format`
  String get invalid_EmailAddress_format {
    return Intl.message(
      'Invalid Email Address format',
      name: 'invalid_EmailAddress_format',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enter_password {
    return Intl.message(
      'Enter your password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get enter_valid_email {
    return Intl.message(
      'Please enter a valid email address',
      name: 'enter_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Facebook`
  String get continue_with_facebook {
    return Intl.message(
      'Continue with Facebook',
      name: 'continue_with_facebook',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get continue_with_google {
    return Intl.message(
      'Continue with Google',
      name: 'continue_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account?`
  String get no_account {
    return Intl.message(
      'Don’t have an account?',
      name: 'no_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message(
      'Sign Up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Enter your username`
  String get enterUsername {
    return Intl.message(
      'Enter your username',
      name: 'enterUsername',
      desc: '',
      args: [],
    );
  }

  /// `Enter EmailAddress `
  String get enterEmailAddress {
    return Intl.message(
      'Enter EmailAddress ',
      name: 'enterEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Email Address format`
  String get wrongEmailAddressFormat {
    return Intl.message(
      'Wrong Email Address format',
      name: 'wrongEmailAddressFormat',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get enterPassword {
    return Intl.message(
      'Enter password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password must meet the requirements`
  String get password_validation {
    return Intl.message(
      'Password must meet the requirements',
      name: 'password_validation',
      desc: '',
      args: [],
    );
  }

  /// `Enter confirm password`
  String get enterConfirmPassword {
    return Intl.message(
      'Enter confirm password',
      name: 'enterConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password does not match`
  String get wrongConfirmPassword {
    return Intl.message(
      'Confirm password does not match',
      name: 'wrongConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message(
      'See All',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get PrivacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'PrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get TermsAndConditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'TermsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get AboutUs {
    return Intl.message(
      'About Us',
      name: 'AboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Login Successful`
  String get LoginSuccessful {
    return Intl.message(
      'Login Successful',
      name: 'LoginSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `User does not exist or password is incorrect`
  String get UserDoesNotExistOrPasswordIsIncorrect {
    return Intl.message(
      'User does not exist or password is incorrect',
      name: 'UserDoesNotExistOrPasswordIsIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Continue as Guest`
  String get continue_as_guest {
    return Intl.message(
      'Continue as Guest',
      name: 'continue_as_guest',
      desc: '',
      args: [],
    );
  }

  /// `IMAX Cinema`
  String get IMAX_Cinema {
    return Intl.message(
      'IMAX Cinema',
      name: 'IMAX_Cinema',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Movies`
  String get movies {
    return Intl.message(
      'Movies',
      name: 'movies',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// ` Add Comment`
  String get addComment {
    return Intl.message(
      ' Add Comment',
      name: 'addComment',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `LogOut`
  String get logOut {
    return Intl.message(
      'LogOut',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Personal Info`
  String get personalInfo {
    return Intl.message(
      'Personal Info',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `language`
  String get language {
    return Intl.message(
      'language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `The luxurious seats and immersive sound system make for a truly unforgettable`
  String
      get theLuxuriousSeatsAndImmersiveSoundSystemMakeForATrulyUnforgettable {
    return Intl.message(
      'The luxurious seats and immersive sound system make for a truly unforgettable',
      name:
          'theLuxuriousSeatsAndImmersiveSoundSystemMakeForATrulyUnforgettable',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, there was an error. Please try again later.`
  String get SorryThereWasAnErrorPleaseTryAgainLater {
    return Intl.message(
      'Sorry, there was an error. Please try again later.',
      name: 'SorryThereWasAnErrorPleaseTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `StatUp is planned for 2025, a type of theater known for its large screen size and high-quality sound system. It offers an immersive viewing experience for movies, documentaries, and other content.`
  String
      get StatUpIsPlannedFor2025TypeOfTheaterKnownForItsLargeScreenSizeAndHighQualitySoundSystemItOffersAnImmersiveViewingExperienceForMoviesDocumentariesAndOtherContent {
    return Intl.message(
      'StatUp is planned for 2025, a type of theater known for its large screen size and high-quality sound system. It offers an immersive viewing experience for movies, documentaries, and other content.',
      name:
          'StatUpIsPlannedFor2025TypeOfTheaterKnownForItsLargeScreenSizeAndHighQualitySoundSystemItOffersAnImmersiveViewingExperienceForMoviesDocumentariesAndOtherContent',
      desc: '',
      args: [],
    );
  }

  /// `Shazam: Fury of the Gods`
  String get ShazamFuryOfTheGods {
    return Intl.message(
      'Shazam: Fury of the Gods',
      name: 'ShazamFuryOfTheGods',
      desc: '',
      args: [],
    );
  }

  /// `Avengers: Infinity War`
  String get AvengersInfinityWar {
    return Intl.message(
      'Avengers: Infinity War',
      name: 'AvengersInfinityWar',
      desc: '',
      args: [],
    );
  }

  /// `2 hours 5 minutes`
  String get TwoHoursFiveMinutes {
    return Intl.message(
      '2 hours 5 minutes',
      name: 'TwoHoursFiveMinutes',
      desc: '',
      args: [],
    );
  }

  /// `Action, Sci-Fi`
  String get ActionSciFi {
    return Intl.message(
      'Action, Sci-Fi',
      name: 'ActionSciFi',
      desc: '',
      args: [],
    );
  }

  /// `Great selection of movies. Highly recommended!`
  String get GreatSelectionOfMoviesHighlyRecommended {
    return Intl.message(
      'Great selection of movies. Highly recommended!',
      name: 'GreatSelectionOfMoviesHighlyRecommended',
      desc: '',
      args: [],
    );
  }

  /// `The luxurious seats and immersive sound system make for a truly unforgettable experience.`
  String
      get TheLuxuriousSeatsAndImmersiveSoundSystemMakeForATrulyUnforgettable {
    return Intl.message(
      'The luxurious seats and immersive sound system make for a truly unforgettable experience.',
      name:
          'TheLuxuriousSeatsAndImmersiveSoundSystemMakeForATrulyUnforgettable',
      desc: '',
      args: [],
    );
  }

  /// `The cinema's modern design and aesthetically pleasing decor create a welcoming atmosphere.`
  String
      get TheCinemasModernDesignAndAestheticallyPleasingDecorCreateAWelcomingAtmosphere {
    return Intl.message(
      'The cinema\'s modern design and aesthetically pleasing decor create a welcoming atmosphere.',
      name:
          'TheCinemasModernDesignAndAestheticallyPleasingDecorCreateAWelcomingAtmosphere',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notifications {
    return Intl.message(
      'Notification',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `zakaria1`
  String get zakaria1 {
    return Intl.message(
      'zakaria1',
      name: 'zakaria1',
      desc: '',
      args: [],
    );
  }

  /// `Ahmed Sayed`
  String get ahmedSayed {
    return Intl.message(
      'Ahmed Sayed',
      name: 'ahmedSayed',
      desc: '',
      args: [],
    );
  }

  /// `No Results Found`
  String get noResultsFound {
    return Intl.message(
      'No Results Found',
      name: 'noResultsFound',
      desc: '',
      args: [],
    );
  }

  /// `Show this QR code to the ticket\n  counter to receive your ticket`
  String get showThisQRCodeToTheTicketCounterToReceiveYourTicket {
    return Intl.message(
      'Show this QR code to the ticket\n  counter to receive your ticket',
      name: 'showThisQRCodeToTheTicketCounterToReceiveYourTicket',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Sorry No WatchList Movies Yet`
  String get sorryNoWatchListMoviesYet {
    return Intl.message(
      'Sorry No WatchList Movies Yet',
      name: 'sorryNoWatchListMoviesYet',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out ?`
  String get areYouSureYouWantToLogOut {
    return Intl.message(
      'Are you sure you want to log out ?',
      name: 'areYouSureYouWantToLogOut',
      desc: '',
      args: [],
    );
  }

  /// `Invalid e-mail format`
  String get invalidEmailFormat {
    return Intl.message(
      'Invalid e-mail format',
      name: 'invalidEmailFormat',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy easy ticket booking and personalized recommendations`
  String get enjoyEasyTicketBookingAndPersonalizedRecommendations {
    return Intl.message(
      'Enjoy easy ticket booking and personalized recommendations',
      name: 'enjoyEasyTicketBookingAndPersonalizedRecommendations',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to YourSeat !`
  String get welcomeToYourSeat {
    return Intl.message(
      'Welcome to YourSeat !',
      name: 'welcomeToYourSeat',
      desc: '',
      args: [],
    );
  }

  /// `Start Using the App ->`
  String get startUsingTheApp {
    return Intl.message(
      'Start Using the App ->',
      name: 'startUsingTheApp',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Download ticket`
  String get downloadTicket {
    return Intl.message(
      'Download ticket',
      name: 'downloadTicket',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `You Have To Sign In To Continue`
  String get youHaveToSignInToContinue {
    return Intl.message(
      'You Have To Sign In To Continue',
      name: 'youHaveToSignInToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Data Updated Successfully`
  String get dataUpdatedSuccessfully {
    return Intl.message(
      'Data Updated Successfully',
      name: 'dataUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `New movies ! Easy booking`
  String get newMoviesEasyBooking {
    return Intl.message(
      'New movies ! Easy booking',
      name: 'newMoviesEasyBooking',
      desc: '',
      args: [],
    );
  }

  /// `Book tickets for the latest movies at the cinema nearest to you.`
  String get bookTicketsForTheLatestMoviesAtTheCinemaNearestToYou {
    return Intl.message(
      'Book tickets for the latest movies at the cinema nearest to you.',
      name: 'bookTicketsForTheLatestMoviesAtTheCinemaNearestToYou',
      desc: '',
      args: [],
    );
  }

  /// `Favorite it!\n Add watchlist`
  String get favoriteItAddWatchlist {
    return Intl.message(
      'Favorite it!\n Add watchlist',
      name: 'favoriteItAddWatchlist',
      desc: '',
      args: [],
    );
  }

  /// `Favorites or watchlist for quick access to your beloved movies.`
  String get favoritesOrWatchlistForQuickAccessToYourBelovedMovies {
    return Intl.message(
      'Favorites or watchlist for quick access to your beloved movies.',
      name: 'favoritesOrWatchlistForQuickAccessToYourBelovedMovies',
      desc: '',
      args: [],
    );
  }

  /// `Ahmed Sayed`
  String get ahmedSayed1 {
    return Intl.message(
      'Ahmed Sayed',
      name: 'ahmedSayed1',
      desc: '',
      args: [],
    );
  }

  /// `Esam`
  String get Esam {
    return Intl.message(
      'Esam',
      name: 'Esam',
      desc: '',
      args: [],
    );
  }

  /// `Movies`
  String get moviess {
    return Intl.message(
      'Movies',
      name: 'moviess',
      desc: '',
      args: [],
    );
  }

  /// `There are no comments yet.`
  String get Therearenocommentsyet {
    return Intl.message(
      'There are no comments yet.',
      name: 'Therearenocommentsyet',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Watch List`
  String get watchlist {
    return Intl.message(
      'Watch List',
      name: 'watchlist',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Tickets`
  String get tickets {
    return Intl.message(
      'Tickets',
      name: 'tickets',
      desc: '',
      args: [],
    );
  }

  /// `ask me here...`
  String get askmehere {
    return Intl.message(
      'ask me here...',
      name: 'askmehere',
      desc: '',
      args: [],
    );
  }

  /// `Hello , I’m your AI\nAssistant !`
  String get HelloIamyourAIAssistant {
    return Intl.message(
      'Hello , I’m your AI\nAssistant !',
      name: 'HelloIamyourAIAssistant',
      desc: '',
      args: [],
    );
  }

  /// `typing...`
  String get typing {
    return Intl.message(
      'typing...',
      name: 'typing',
      desc: '',
      args: [],
    );
  }

  /// `can i help you?`
  String get canyouhelp {
    return Intl.message(
      'can i help you?',
      name: 'canyouhelp',
      desc: '',
      args: [],
    );
  }

  /// ` Yes`
  String get yes {
    return Intl.message(
      ' Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Confirm OTP code`
  String get ConfirmOTPcode {
    return Intl.message(
      'Confirm OTP code',
      name: 'ConfirmOTPcode',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter The 6 Digit Code Sent To Your Email`
  String get PleaseEnterThe6DigitCodeSentToYourEmail {
    return Intl.message(
      'Please Enter The 6 Digit Code Sent To Your Email',
      name: 'PleaseEnterThe6DigitCodeSentToYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Resend limit reached for today.`
  String get Resendlimitreachedfortoday {
    return Intl.message(
      'Resend limit reached for today.',
      name: 'Resendlimitreachedfortoday',
      desc: '',
      args: [],
    );
  }

  /// `Resend!`
  String get Resend {
    return Intl.message(
      'Resend!',
      name: 'Resend',
      desc: '',
      args: [],
    );
  }

  /// `Esam`
  String get Esam1 {
    return Intl.message(
      'Esam',
      name: 'Esam1',
      desc: '',
      args: [],
    );
  }

  /// `Rahaf`
  String get rahaf {
    return Intl.message(
      'Rahaf',
      name: 'rahaf',
      desc: '',
      args: [],
    );
  }

  /// `Now Playing`
  String get nowPlaying {
    return Intl.message(
      'Now Playing',
      name: 'nowPlaying',
      desc: '',
      args: [],
    );
  }

  /// `Coming Soon`
  String get comingSoon {
    return Intl.message(
      'Coming Soon',
      name: 'comingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Watch Trailer`
  String get watchTrailer {
    return Intl.message(
      'Watch Trailer',
      name: 'watchTrailer',
      desc: '',
      args: [],
    );
  }

  /// `Movie genre : `
  String get movieGenre {
    return Intl.message(
      'Movie genre : ',
      name: 'movieGenre',
      desc: '',
      args: [],
    );
  }

  /// `Censorship : `
  String get censorship {
    return Intl.message(
      'Censorship : ',
      name: 'censorship',
      desc: '',
      args: [],
    );
  }

  /// `StoryLine`
  String get storyLine {
    return Intl.message(
      'StoryLine',
      name: 'storyLine',
      desc: '',
      args: [],
    );
  }

  /// `Director`
  String get director {
    return Intl.message(
      'Director',
      name: 'director',
      desc: '',
      args: [],
    );
  }

  /// `Actor`
  String get actor {
    return Intl.message(
      'Actor',
      name: 'actor',
      desc: '',
      args: [],
    );
  }

  /// `See more`
  String get seeMore {
    return Intl.message(
      'See more',
      name: 'seeMore',
      desc: '',
      args: [],
    );
  }

  /// `See less`
  String get seeLess {
    return Intl.message(
      'See less',
      name: 'seeLess',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get forgetPassword {
    return Intl.message(
      'Forget Password',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Email To Receive\na Verification Card`
  String get pleaseEnterYourEmailToReceiveAVerificationCard {
    return Intl.message(
      'Please Enter Your Email To Receive\na Verification Card',
      name: 'pleaseEnterYourEmailToReceiveAVerificationCard',
      desc: '',
      args: [],
    );
  }

  /// `Create New Password`
  String get createNewPassword {
    return Intl.message(
      'Create New Password',
      name: 'createNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Your New Password Must Be \nDifferent from Previously \nUsed Password `
  String get yourNewPasswordMustBeDifferentFromPreviouslyUsedPassword {
    return Intl.message(
      'Your New Password Must Be \nDifferent from Previously \nUsed Password ',
      name: 'yourNewPasswordMustBeDifferentFromPreviouslyUsedPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Payment\nSuccessful !`
  String get paymentSuccessful {
    return Intl.message(
      'Payment\nSuccessful !',
      name: 'paymentSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Ticket`
  String get ticket {
    return Intl.message(
      'Ticket',
      name: 'ticket',
      desc: '',
      args: [],
    );
  }

  /// `Refund\nSuccessful !`
  String get refundSuccessful {
    return Intl.message(
      'Refund\nSuccessful !',
      name: 'refundSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Seat :`
  String get seat {
    return Intl.message(
      'Seat :',
      name: 'seat',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `pay with card`
  String get payWithCard {
    return Intl.message(
      'pay with card',
      name: 'payWithCard',
      desc: '',
      args: [],
    );
  }

  /// `instapay`
  String get instapay {
    return Intl.message(
      'instapay',
      name: 'instapay',
      desc: '',
      args: [],
    );
  }

  /// `complete your payment in`
  String get completeYourPaymentIn {
    return Intl.message(
      'complete your payment in',
      name: 'completeYourPaymentIn',
      desc: '',
      args: [],
    );
  }

  /// `Payment Refund`
  String get paymentRefund {
    return Intl.message(
      'Payment Refund',
      name: 'paymentRefund',
      desc: '',
      args: [],
    );
  }

  /// `Payment Refund Method`
  String get paymentRefundMethod {
    return Intl.message(
      'Payment Refund Method',
      name: 'paymentRefundMethod',
      desc: '',
      args: [],
    );
  }

  /// `Payment Policy`
  String get paymentPolicy {
    return Intl.message(
      'Payment Policy',
      name: 'paymentPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Currency:`
  String get currency {
    return Intl.message(
      'Currency:',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `All transactions on YourSeat will be\nprocessed in Local Currency.\n`
  String get allTransactionsOnYourSeatWillBeProcessedInLocalCurrency {
    return Intl.message(
      'All transactions on YourSeat will be\nprocessed in Local Currency.\n',
      name: 'allTransactionsOnYourSeatWillBeProcessedInLocalCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Payment Timing:`
  String get paymentTiming {
    return Intl.message(
      'Payment Timing:',
      name: 'paymentTiming',
      desc: '',
      args: [],
    );
  }

  /// `1- Payments must be completed at the time of booking.\n2- Your booking will only be confirmed upon successful payment.\n3- Partial payments are not accepted. \n4- Full payment is required for ticket confirmation.`
  String
      get paymentsMustBeCompletedAtTheTimeOfBookingYourBookingWillOnlyBeConfirmedUponSuccessfulPaymentPartialPaymentsAreNotAcceptedFullPaymentIsRequiredForTicketConfirmation {
    return Intl.message(
      '1- Payments must be completed at the time of booking.\n2- Your booking will only be confirmed upon successful payment.\n3- Partial payments are not accepted. \n4- Full payment is required for ticket confirmation.',
      name:
          'paymentsMustBeCompletedAtTheTimeOfBookingYourBookingWillOnlyBeConfirmedUponSuccessfulPaymentPartialPaymentsAreNotAcceptedFullPaymentIsRequiredForTicketConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Booking Confirmation :`
  String get bookingConfirmation {
    return Intl.message(
      'Booking Confirmation :',
      name: 'bookingConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Once payment is successful,a confirmation email\nwith ticket details and booking information\nwill be sent to the registered email address. If you do not receive a confirmation within 30 minutes of payment, please contact our support team at support@yourseat.com.`
  String
      get oncePaymentIsSuccessfulAConfirmationEmailWithTicketDetailsAndBookingInformationWillBeSentToTheRegisteredEmailAddressIfYouDoNotReceiveAConfirmationWithinThirtyMinutesOfPaymentPleaseContactOurSupportTeamAtSupportYourSeatCom {
    return Intl.message(
      'Once payment is successful,a confirmation email\nwith ticket details and booking information\nwill be sent to the registered email address. If you do not receive a confirmation within 30 minutes of payment, please contact our support team at support@yourseat.com.',
      name:
          'oncePaymentIsSuccessfulAConfirmationEmailWithTicketDetailsAndBookingInformationWillBeSentToTheRegisteredEmailAddressIfYouDoNotReceiveAConfirmationWithinThirtyMinutesOfPaymentPleaseContactOurSupportTeamAtSupportYourSeatCom',
      desc: '',
      args: [],
    );
  }

  /// `Cancellations & Refunds:`
  String get cancellationsRefunds {
    return Intl.message(
      'Cancellations & Refunds:',
      name: 'cancellationsRefunds',
      desc: '',
      args: [],
    );
  }

  /// `1-If canceled more than 12 hours before the movie's start time,the customer is eligible\nfor a full refund.\n 2-If canceled within 12 hours but more than 30 minutes before the movie's start time,the customer will receive 50% of the\nticket amount as a refund.\n 3- Cancellations made less than 30 minutes before the movie's start time are\n non-refundable Refund Process: In eligible cases, refunds will be credited back to the\noriginal payment method within (5-10) business days. Bank processing times may vary.\n`
  String
      get ifCanceledMoreThanTwelveHoursBeforeTheMovie_sStartTimeTheCustomerIsEligibleForAFullRefundIfCanceledWithinTwelveHoursButMoreThanThirtyMinutesBeforeTheMovie_sStartTimeTheCustomerWillReceiveFiftyOutOfAHundredOfTheTicketAmountAsARefundCancellationsMadeLessThanThirtyMinutesBeforeTheMovie_sStartTimeAreNonRefundableRefundProcessInEligibleCasesRefundsWillBeCreditedBackToTheOriginalPaymentMethodWithinFive_TenBusinessDaysBankProcessingTimesMayVary {
    return Intl.message(
      '1-If canceled more than 12 hours before the movie\'s start time,the customer is eligible\nfor a full refund.\n 2-If canceled within 12 hours but more than 30 minutes before the movie\'s start time,the customer will receive 50% of the\nticket amount as a refund.\n 3- Cancellations made less than 30 minutes before the movie\'s start time are\n non-refundable Refund Process: In eligible cases, refunds will be credited back to the\noriginal payment method within (5-10) business days. Bank processing times may vary.\n',
      name:
          'ifCanceledMoreThanTwelveHoursBeforeTheMovie_sStartTimeTheCustomerIsEligibleForAFullRefundIfCanceledWithinTwelveHoursButMoreThanThirtyMinutesBeforeTheMovie_sStartTimeTheCustomerWillReceiveFiftyOutOfAHundredOfTheTicketAmountAsARefundCancellationsMadeLessThanThirtyMinutesBeforeTheMovie_sStartTimeAreNonRefundableRefundProcessInEligibleCasesRefundsWillBeCreditedBackToTheOriginalPaymentMethodWithinFive_TenBusinessDaysBankProcessingTimesMayVary',
      desc: '',
      args: [],
    );
  }

  /// `Service Fees:`
  String get serviceFees {
    return Intl.message(
      'Service Fees:',
      name: 'serviceFees',
      desc: '',
      args: [],
    );
  }

  /// `Any service or processing fees associated with the booking are non-refundable.`
  String
      get anyServiceOrProcessingFeesAssociatedWithTheBookingAreNonRefundable {
    return Intl.message(
      'Any service or processing fees associated with the booking are non-refundable.',
      name:
          'anyServiceOrProcessingFeesAssociatedWithTheBookingAreNonRefundable',
      desc: '',
      args: [],
    );
  }

  /// `I agree with privacy policy.`
  String get iAgreeWithPrivacyPolicy {
    return Intl.message(
      'I agree with privacy policy.',
      name: 'iAgreeWithPrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continnue {
    return Intl.message(
      'Continue',
      name: 'continnue',
      desc: '',
      args: [],
    );
  }

  /// `Card information`
  String get cardInformation {
    return Intl.message(
      'Card information',
      name: 'cardInformation',
      desc: '',
      args: [],
    );
  }

  /// `Card Number:`
  String get cardNumber {
    return Intl.message(
      'Card Number:',
      name: 'cardNumber',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date:`
  String get expiryDate {
    return Intl.message(
      'Expiry Date:',
      name: 'expiryDate',
      desc: '',
      args: [],
    );
  }

  /// `CVV:`
  String get cvv {
    return Intl.message(
      'CVV:',
      name: 'cvv',
      desc: '',
      args: [],
    );
  }

  /// `Store card for future use ?`
  String get storeCardForFutureUse {
    return Intl.message(
      'Store card for future use ?',
      name: 'storeCardForFutureUse',
      desc: '',
      args: [],
    );
  }

  /// `Complete your purchase`
  String get completeYourPurchase {
    return Intl.message(
      'Complete your purchase',
      name: 'completeYourPurchase',
      desc: '',
      args: [],
    );
  }

  /// `Rahaf`
  String get rahaf1 {
    return Intl.message(
      'Rahaf',
      name: 'rahaf1',
      desc: '',
      args: [],
    );
  }

  /// `Roaa`
  String get Roaa {
    return Intl.message(
      'Roaa',
      name: 'Roaa',
      desc: '',
      args: [],
    );
  }

  /// `Jan`
  String get jan {
    return Intl.message(
      'Jan',
      name: 'jan',
      desc: '',
      args: [],
    );
  }

  /// `Feb`
  String get feb {
    return Intl.message(
      'Feb',
      name: 'feb',
      desc: '',
      args: [],
    );
  }

  /// `Mar`
  String get mar {
    return Intl.message(
      'Mar',
      name: 'mar',
      desc: '',
      args: [],
    );
  }

  /// `Apr`
  String get apr {
    return Intl.message(
      'Apr',
      name: 'apr',
      desc: '',
      args: [],
    );
  }

  /// `Jun`
  String get jun {
    return Intl.message(
      'Jun',
      name: 'jun',
      desc: '',
      args: [],
    );
  }

  /// `Jul`
  String get jul {
    return Intl.message(
      'Jul',
      name: 'jul',
      desc: '',
      args: [],
    );
  }

  /// `Aug`
  String get aug {
    return Intl.message(
      'Aug',
      name: 'aug',
      desc: '',
      args: [],
    );
  }

  /// `Sep`
  String get sep {
    return Intl.message(
      'Sep',
      name: 'sep',
      desc: '',
      args: [],
    );
  }

  /// `Oct`
  String get oct {
    return Intl.message(
      'Oct',
      name: 'oct',
      desc: '',
      args: [],
    );
  }

  /// `Nov`
  String get nov {
    return Intl.message(
      'Nov',
      name: 'nov',
      desc: '',
      args: [],
    );
  }

  /// `Dec`
  String get dec {
    return Intl.message(
      'Dec',
      name: 'dec',
      desc: '',
      args: [],
    );
  }

  /// `Select Seat`
  String get selectSeat {
    return Intl.message(
      'Select Seat',
      name: 'selectSeat',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get available {
    return Intl.message(
      'Available',
      name: 'available',
      desc: '',
      args: [],
    );
  }

  /// `Reserved`
  String get reserved {
    return Intl.message(
      'Reserved',
      name: 'reserved',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get selected {
    return Intl.message(
      'Selected',
      name: 'selected',
      desc: '',
      args: [],
    );
  }

  /// `The Seat Selected is VIP.`
  String get theSeatSelectedIsVIP {
    return Intl.message(
      'The Seat Selected is VIP.',
      name: 'theSeatSelectedIsVIP',
      desc: '',
      args: [],
    );
  }

  /// `Select Date & Time`
  String get selectDateTime {
    return Intl.message(
      'Select Date & Time',
      name: 'selectDateTime',
      desc: '',
      args: [],
    );
  }

  /// `210.000EGP`
  String get egp {
    return Intl.message(
      '210.000EGP',
      name: 'egp',
      desc: '',
      args: [],
    );
  }

  /// `Buy Ticket`
  String get buyTicket {
    return Intl.message(
      'Buy Ticket',
      name: 'buyTicket',
      desc: '',
      args: [],
    );
  }

  /// `Please rate the movie`
  String get pleaseRateTheMovie {
    return Intl.message(
      'Please rate the movie',
      name: 'pleaseRateTheMovie',
      desc: '',
      args: [],
    );
  }

  /// `Please rate the cinema`
  String get pleaseRateTheCinema {
    return Intl.message(
      'Please rate the cinema',
      name: 'pleaseRateTheCinema',
      desc: '',
      args: [],
    );
  }

  /// `Can you tell us the reason`
  String get canYouTellUsTheReason {
    return Intl.message(
      'Can you tell us the reason',
      name: 'canYouTellUsTheReason',
      desc: '',
      args: [],
    );
  }

  /// `Your evaluation is interested`
  String get yourEvaluationIsInterested {
    return Intl.message(
      'Your evaluation is interested',
      name: 'yourEvaluationIsInterested',
      desc: '',
      args: [],
    );
  }

  /// `Roaa1`
  String get Roaa1 {
    return Intl.message(
      'Roaa1',
      name: 'Roaa1',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
