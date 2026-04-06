// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/presentation/constants/constants.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/pages/about/screens/about_page.dart';
import 'package:news_watch_app/presentation/pages/main/screens/profile_page.dart';
import 'package:news_watch_app/presentation/pages/posts/widgets/settings_item_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final txt = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          txt.txtAppBarSettings,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Gaps.large),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  Constants.borderRadiusCircular,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SettingsItemWidget(
                    icon: Icons.person_outline,
                    title: txt.txtProfile,
                    subtitle: txt.txtManageYourInformation,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Gaps.large),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  SettingsItemWidget(
                    icon: Icons.info_outline,
                    title: txt.txtAbout,
                    subtitle: txt.txtLearnMoreAboutTheApp,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: Gaps.large),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  Constants.borderRadiusCircular,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: SettingsItemWidget(
                icon: Icons.logout_rounded,
                title: txt.txtLogOut,
                subtitle: txt.txtSignOutFromYourAccount,
                iconColor: Colors.redAccent,
                titleColor: Colors.redAccent,
                onTap: () {
                  context.read<AuthCubit>().userlogOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
