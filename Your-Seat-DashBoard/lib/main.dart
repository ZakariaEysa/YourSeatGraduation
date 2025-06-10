import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/signin/auth_cubit/auth_cubit.dart';
import 'package:yourseatgraduationproject/features/admin_flow/signin/view/signin.dart';
import 'package:yourseatgraduationproject/features/admin_flow/payment/data/repos_impl/payment_repo_impl.dart';
import 'package:yourseatgraduationproject/features/admin_flow/payment/data/remote_data_source/payment_remote_data_source.dart';
import 'package:yourseatgraduationproject/features/admin_flow/payment/presentation/cubit/payment_cubit.dart';
import 'package:yourseatgraduationproject/features/admin_flow/setting/presentation/cubit/settings_cubit.dart';
import 'package:yourseatgraduationproject/features/admin_flow/moives/data/movies_cubit/movies_cubit.dart';
import 'features/admin_flow/TicketDetails/data/remote_data_source/ticket_details_remote_data_source.dart';
import 'features/admin_flow/TicketDetails/data/repos_impl/ticket_details_repo_impl.dart';
import 'features/admin_flow/TicketDetails/presentation/cubit/ticket_details_cubit.dart';
import 'features/admin_flow/homepage/cubit/home_cubit.dart';
import 'features/admin_flow/homepage/cubit/sales_dash_cubit/sales_dash_cubit.dart';
import 'firebase_options.dart';
import 'services/simple_bloc_observer_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await ScreenUtil.ensureScreenSize();

  SimpleBlocObserverService();

  // 🔥 Error Handler عشان نعرف فين المشاكل بالظبط
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('⚡️ Error caught: ${details.exceptionAsString()}');
    debugPrintStack(label: '⚡️ Stack trace', stackTrace: details.stack);
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => SalesDashCubit(),
            ),
            BlocProvider(create: (context) => MovieCubit()),
            BlocProvider(create: (context) => AuthCubit()),
            BlocProvider(create: (context) => SettingsCubit()),
            BlocProvider(create: (context) => HomeCubit()),
            BlocProvider(
              create: (context) =>
                  PaymentCubit(PaymentRepoImpl(PaymentRemoteDataSourceImpl())),
            ),
            BlocProvider(
              create: (context) => TicketDetailsCubit(
                  TicketDetailsRepoImpl(TicketDetailsRemoteDataSourceImpl())),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Admin Dashboard",
            theme: ThemeData.dark(),
            home: const SignIn(),
          ),
        );
      },
    );
  }
}
