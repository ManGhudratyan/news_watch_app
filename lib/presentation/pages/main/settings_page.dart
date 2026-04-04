import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/core/extensions/scaffold_extension.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_state.dart';
import 'package:news_watch_app/presentation/pages/about/about_page.dart';
import 'package:news_watch_app/presentation/pages/main/profile_page.dart';
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
      ListTileWidget(
        icon: const Icon(Icons.person),
        title: txt.txtProfile,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
        },
      ),
      ListTileWidget(
        icon: const Icon(Icons.info_outline),
        title: txt.txtAbout,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AboutPage()),
          );
        },
      ),
      ListTileWidget(
        icon: const Icon(Icons.logout),
        title: txt.txtLogOut,
        onTap: () {
          context.read<AuthCubit>().userlogOut();
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          txt.txtAppBarSettings,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
        ),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, authState) {
          if (authState.loggedOut == true) {
            context.showSnackBarMessage(txt.txtLoggedOutSuccessfully);
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushNamed(RouteConstants.signInPage);
          }

          if (authState.error?.isNotEmpty ?? false) {
            context.showSnackBarMessage(authState.error ?? 'error');
          }
        },
        builder: (context, authState) {
          return ListView(children: items);
        },
      ),
    );
  }
}
