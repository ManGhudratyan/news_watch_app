import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/core/routes/routes.dart';
import 'package:news_watch_app/data/repositories/add_post_repository_imp.dart';
import 'package:news_watch_app/data/repositories/user_repository_imp.dart';
import 'package:news_watch_app/presentation/pages/auth/logic/user_bloc.dart';
import 'package:news_watch_app/presentation/pages/posts/logic/add_post_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  final userRepository = UserRepositoryImp();
  final addPostRepository = AddPostRepositoryImp();

  final isLoggedIn = await userRepository.isLoggedIn();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (_) => UserBloc(userRepository)..add(GetUserEvent()),
        ),
        BlocProvider<AddPostBloc>(
          create: (_) => AddPostBloc(addPostRepository: addPostRepository),
        ),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn
          ? RouteConstants.mainPage
          : RouteConstants.initialRoute,
      onGenerateRoute: Routes.generateRoute,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('am')],
    );
  }
}
