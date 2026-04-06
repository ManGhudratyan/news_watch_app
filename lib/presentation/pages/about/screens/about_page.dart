// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/core/enums/radio_type.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_state.dart';
import 'package:news_watch_app/presentation/constants/assets.dart';
import 'package:news_watch_app/presentation/constants/constants.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/pages/about/widget/user_info_widget.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          final user = authState.user;

          if (user == null) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final imagePath = user.imagePath;
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10,
                  bottom: Gaps.largest,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(219, 165, 129, 123),
                      Color(0xFF6C63FF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Constants.borderRadiusCircular),
                    bottomRight: Radius.circular(
                      Constants.borderRadiusCircular,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 42,
                        backgroundImage:
                            imagePath != null && imagePath.isNotEmpty
                            ? FileImage(File(imagePath))
                            : AssetImage(Assets.userImage) as ImageProvider,
                      ),
                    ),
                    SizedBox(height: Gaps.large),
                    Text(
                      user.username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: Gaps.small),
                    Text(
                      user.email,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(Gaps.large),
                  child: Container(
                    padding: EdgeInsets.all(Gaps.large),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                          color: Colors.black.withOpacity(0.05),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        UserInfoWidget(
                          icon: Icons.person,
                          title: text.txtUsername,
                          value: user.username,
                        ),
                        const Divider(),
                        UserInfoWidget(
                          icon: Icons.email,
                          title: text.txtEmail,
                          value: user.email,
                        ),
                        const Divider(),
                        UserInfoWidget(
                          icon: Icons.location_city,
                          title: text.txtCity,
                          value: user.userCity ?? "Not set",
                        ),
                        const Divider(),
                        UserInfoWidget(
                          icon: Icons.phone_in_talk_outlined,
                          title: text.txtPhoneNumber,
                          value: user.phoneNumber ?? text.txtPhoneNumber,
                        ),
                        const Divider(),
                        UserInfoWidget(
                          icon: Icons.report_gmailerrorred,
                          title: text.txtIamA,
                          value: (user.radioType ?? RadioType.visitor).name,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
