import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/create_event/screen/CreateEventScreen.dart';
import 'package:evently/ui/forget_password/screen/forget_password_screen.dart';
import 'package:evently/ui/home/screen/home_screen.dart';
import 'package:evently/ui/login/screen/login_screen.dart';
import 'package:evently/ui/register/screen/register_screen.dart';
import 'package:evently/ui/start/screen/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/providers/ThemeProvider.dart';
import 'core/providers/UserProvider.dart';
import 'core/resources/AppStyle.dart';
import 'firebase_options.dart';
import 'ui/splash/screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()..initTheme()),
          ChangeNotifierProvider(create: (_) => UserProvider()), // ✅ إضافة UserProvider
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Evently',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      themeMode: themeProvider.themeMode,
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        StartScreen.routeName: (_) => StartScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        ForgetPasswordScreen.routeName: (_) => ForgetPasswordScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        CreateEventScreen.routeName: (_) => CreateEventScreen(),
      },
    );
  }
}
