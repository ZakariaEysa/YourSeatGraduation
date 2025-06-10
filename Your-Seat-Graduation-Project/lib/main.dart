import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'features/user_flow/movie_details/data/remote_data_source/movie_details_remote_data_source.dart';
import 'features/user_flow/movie_details/data/repos_impl/movie_details_repo_impl.dart';
import 'features/user_flow/movie_details/presentation/cubit/movie_details_cubit.dart';
import 'data/hive_storage.dart';
import 'features/user_flow/notification/notification_cubit/notification_cubit.dart';
import 'features/user_flow/Watch_list/presentation/cubit/watch_list_cubit.dart';
import 'features/user_flow/auth/presentation/cubit/auth_cubit.dart';
import 'features/user_flow/cinema_details/presentation/cubit/cinema_cubit.dart';
import 'features/user_flow/home/presentation/Widget/Cinema_item/Cubit/item_cubit.dart';
import 'features/user_flow/now_playing/cubit/coming_soon_cubit.dart';
import 'widgets/application_theme/application_theme.dart';
import 'config/language_bloc/switch_language_bloc.dart';
import 'data/hive_keys.dart';
import 'features/user_flow/Splash_screen/splash_screen.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/user_flow/Watch_list/favorite_movies_provider/favorite_movies_provider.dart';
import 'features/user_flow/auth/data/remote_data_source/auth_remote_data_source.dart';
import 'features/user_flow/auth/data/repos_impl/auth_repo_impl.dart';
import 'features/user_flow/home/presentation/Widget/cubit/movies_cubit.dart';
import 'utils/app_initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await AppInitializer.initializeApp();

  await AppInitializer.initializeEssentialParts();
  await AppInitializer.initializeRemainingAsyncTasks();

  runApp(
    MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteMoviesProvider()),
        BlocProvider(create: (_) => SwitchLanguageCubit()),
        BlocProvider(
          create: (_) => AuthCubit(
            AuthRepoImpl(AuthRemoteDataSourceImpl(
              FirebaseAuth.instance,
              GoogleSignIn(),
            )),
          ),
        ),
        BlocProvider(
          create: (_) => MovieDetailsCubit(
            MovieDetailsRepoImpl(MovieDetailsRemoteDataSourceImpl()),
          ),
        ),
        BlocProvider(create: (_) => CinemaCubit()),
        BlocProvider(create: (_) => CinemaItemCubit()),
        BlocProvider(create: (_) => MovieCarouselCubit()),
        BlocProvider(create: (_) => ComingSoonCubit()),
        BlocProvider(create: (_) => WatchListCubit()),
        BlocProvider(create: (_) => NotificationCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()?.restartApp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationTheme(),
      child: Consumer<ApplicationTheme>(
        builder: (context, theme, child) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            useInheritedMediaQuery: true,
            ensureScreenSize: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp(
                theme: theme.currentTheme,
                locale: HiveStorage.get(HiveKeys.isArabic)
                    ? const Locale('ar')
                    : const Locale('en'),
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                debugShowCheckedModeBanner: false,
                builder: (context, child) {
                  child = BotToastInit()(context, child);
                  return child;
                },
                navigatorObservers: [BotToastNavigatorObserver()],
                home: SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
