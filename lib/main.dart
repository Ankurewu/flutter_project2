import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_riverpod/common/models/user_model.dart';
import 'package:to_do_riverpod/common/routes/routes.dart';
import 'package:to_do_riverpod/common/utils/constants.dart';
import 'package:to_do_riverpod/features/auth/controllers/user_controller.dart';
import 'package:to_do_riverpod/features/todo/pages/homepage.dart';
import 'package:to_do_riverpod/features/todo/pages/onboarding.dart';
import 'package:to_do_riverpod/firebase_options.dart';



void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  runApp( ProviderScope(child:const MyApp()));
}

class MyApp extends ConsumerWidget{
  const MyApp({super.key});


  static final DefaultLightColorScheme= ColorScheme.fromSwatch(
    primarySwatch: Colors.blue);

  static final DefaultDarkColorScheme= ColorScheme.fromSwatch(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue);
  
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ref.read(userProvider.notifier).refresh();
    List<UserModel> users= ref.watch(userProvider);
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 825),
      minTextAdapt: true,
      builder: (context,child) {
        return DynamicColorBuilder(
          builder: (lightColorScheme,darkColorScheme) {
            return MaterialApp(
              title: 'Dbestech',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: AppConst.kGreyBk ,
                colorScheme: lightColorScheme??DefaultLightColorScheme,
                  useMaterial3: true,
              ),
              darkTheme:ThemeData(
                colorScheme: darkColorScheme?? DefaultDarkColorScheme,
                 scaffoldBackgroundColor: AppConst.kGreyBk ,
                 useMaterial3: true),
              themeMode: ThemeMode.dark,
              home: users.isEmpty? const OnBoarding(): const HomePage(),
              onGenerateRoute: Routes.onGenerateRoute,
            );
          }
        );
      }
    );
  }
}