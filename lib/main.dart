import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/forget_password/screen/forget_password_screen.dart';
import 'package:evently/ui/home/screen/home_screen.dart';
import 'package:evently/ui/login/screen/login_screen.dart';
import 'package:evently/ui/onBoarding/screen/onBoarding_screen.dart';
import 'package:evently/ui/register/screen/register_screen.dart';
import 'package:evently/ui/splash/screen/splash_screen.dart';
import 'package:evently/ui/start/screen/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ThemeProvider.dart';
import 'core/remote/local/PrefsManager.dart';
import 'core/resources/AppStyle.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsManager.init();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider()..initTheme(),
      child: EasyLocalization(
          path: "assets/translations",
          supportedLocales: [
            Locale("en"),
            Locale("ar"),
          ],
          fallbackLocale: Locale("en"),
          child: const MyApp())));
}
// .
// ..
// ...
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      themeMode:themeProvider.themeMode,
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute:SplashScreen.routeName ,
      routes: {
        SplashScreen.routeName:(_)=>SplashScreen(),
        StartScreen.routeName:(_)=>StartScreen(),
        OnboardingScreen.routeName: (_) =>  OnboardingScreen(),
        LoginScreen.routeName:(_)=>LoginScreen(),
        ForgetPasswordScreen.routeName:(_)=>ForgetPasswordScreen(),
        RegisterScreen.routeName:(_)=>RegisterScreen(),
        HomeScreen.routeName:(_)=>HomeScreen()
      },
    );
  }
}

