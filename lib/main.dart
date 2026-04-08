import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/core/routes/app_router.dart';
import 'package:news_watch_app/cubits/add_post/cubit/add_post_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/cubits/connectivity/connectivity_cubit.dart';
// import 'package:news_watch_app/cubits/connectivity/connectivity_cubit.dart';
import 'package:news_watch_app/data/repositories/add_post_repository_imp.dart';
import 'package:news_watch_app/data/repositories/user_repository_imp.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final userRepository = UserRepositoryImp();
  final addPostRepository = AddPostRepositoryImp();

  await userRepository.isLoggedIn();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityCubit>(create: (_) => ConnectivityCubit()),
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(userRepository)..getLoggedInUser(),
        ),
        BlocProvider<AddPostCubit>(
          create: (_) => AddPostCubit(addPostRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );

  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('am'), Locale('ru')],
    );
  }
}
