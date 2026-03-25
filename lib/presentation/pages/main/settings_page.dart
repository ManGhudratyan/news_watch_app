import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/presentation/pages/auth/logic/user_bloc.dart';
import 'package:news_watch_app/presentation/widgets/list_tile_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final txt = AppLocalizations.of(context)!;

    final List<ListTileWidget> items = [
      ListTileWidget(icon: const Icon(Icons.person), title: txt.txtProfile),
      ListTileWidget(icon: const Icon(Icons.wallet), title: txt.txtMyWallet),
      ListTileWidget(
        icon: const Icon(Icons.photo_size_select_actual_outlined),
        title: txt.txtMyPost,
      ),
      ListTileWidget(
        icon: const Icon(Icons.podcasts),
        title: txt.txtBoostYourPost,
      ),
      ListTileWidget(
        icon: const Icon(Icons.notifications),
        title: txt.txtNotifications,
      ),
      ListTileWidget(
        icon: const Icon(Icons.description),
        title: txt.txtTermsAndConditions,
      ),
      ListTileWidget(icon: const Icon(Icons.info_outline), title: txt.txtAbout),
      ListTileWidget(
        icon: const Icon(Icons.star_border),
        title: txt.txtWatchAdsAndEarn,
      ),
      ListTileWidget(
        icon: const Icon(Icons.refresh),
        title: txt.txtReferAndEarn,
      ),
      ListTileWidget(
        icon: const Icon(Icons.logout),
        title: txt.txtLogOut,
        onTap: () {
          context.read<UserBloc>().add(UserLogoutEvent());
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(txt.txtAppBarSettings),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoggedOut) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(txt.txtLoggedOutSuccessfully)),
            );
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushNamed(RouteConstants.signInPage);
          }

          if (state is UserError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return ListView(children: items);
        },
      ),
    );
  }
}
