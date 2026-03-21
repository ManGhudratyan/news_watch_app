import 'package:flutter/material.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/presentation/widgets/list_tile_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.txtAppBarSettings),
      ),
      body: Column(
        children: [
          ListTileWidget(
            title: AppLocalizations.of(context)!.txtMyWallet,
            icon: Icon(Icons.abc),
          ),
          ListTileWidget(
            title: AppLocalizations.of(context)!.txtMyPost,
            icon: Icon(Icons.wallet),
          ),
          ListTileWidget(
            title: AppLocalizations.of(context)!.txtBoostYourPost,
            icon: Icon(Icons.podcasts),
          ),
          ListTileWidget(
            title: AppLocalizations.of(context)!.txtNotifications,
            icon: Icon(Icons.notifications),
          ),
          ListTileWidget(
            title: AppLocalizations.of(context)!.txtTermsAndConditions,
            icon: Icon(Icons.door_back_door),
          ),
          ListTileWidget(
            title: AppLocalizations.of(context)!.txtAbout,
            icon: Icon(Icons.question_mark_outlined),
          ),
          ListTileWidget(
            title: AppLocalizations.of(context)!.txtWatchAdsAndEarn,
            icon: Icon(Icons.star_border),
          ),
          ListTileWidget(
            title: AppLocalizations.of(context)!.txtReferAndEarn,
            icon: Icon(Icons.refresh_sharp),
          ),
          ListTileWidget(
            title: AppLocalizations.of(context)!.txtLogOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
