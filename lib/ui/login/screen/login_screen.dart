import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/home/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../ThemeProvider.dart';
import '../../../core/resources/AssetsManager.dart';
import '../../../core/resources/constants.dart';
import '../../../core/reusable_components/CustomButton.dart';
import '../../../core/reusable_components/CustomField.dart';
import '../../../core/reusable_components/CustomSwitch.dart';
import '../../../services/google_auth.dart';
import '../../forget_password/screen/forget_password_screen.dart';
import '../../register/screen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedLanguage = 0;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginWithEmailAndPassword() async {
    if (formKey.currentState!.validate()) {
      try {
        final credential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (credential.user != null) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      } on FirebaseAuthException catch (e) {
        String message = "";
        if (e.code == 'user-not-found') {
          message = "No user found for that email.";
        } else if (e.code == 'wrong-password') {
          message = "Wrong password provided.";
        } else {
          message = e.message ?? "Login failed";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    }
  }

  Future<void> _loginWithGoogle() async {
    final firebaseServices = FirebaseServices();
    final user = await firebaseServices.signInWithGoogle();
    if (user != null) {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (context.locale.languageCode == "ar") {
      selectedLanguage = 1;
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AssetsManager.logo),
                  const SizedBox(height: 24),
                  CustomField(
                    keyboard: TextInputType.emailAddress,
                    controller: emailController,
                    hint: 'email'.tr(),
                    prefix: AssetsManager.email,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "shouldEmpty".tr();
                      }
                      if (!RegExp(emailRegex).hasMatch(value)) {
                        return "Email not valid";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomField(
                    keyboard: TextInputType.visiblePassword,
                    controller: passwordController,
                    hint: 'password'.tr(),
                    prefix: AssetsManager.lock,
                    isPassword: true,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "shouldEmpty".tr();
                      }
                      if (value.length < 8) {
                        return "password mustn't be less than 8 char";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, ForgetPasswordScreen.routeName);
                      },
                      child: Text(
                        "forgetPass".tr(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 16,
                          decorationColor:
                          Theme.of(context).colorScheme.primary,
                          decorationThickness: 2,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      title: "login".tr(),
                      onClick: _loginWithEmailAndPassword,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: Image.asset(
                        'assets/images/google.jpeg',
                        height: 24,
                        width: 24,
                      ),
                      label: Text(
                        context.locale.languageCode == "ar"
                            ? "تسجيل الدخول  Google"
                            : "Sign in with Google",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      onPressed: _loginWithGoogle,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "dontHaveAccount".tr(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RegisterScreen.routeName);
                        },
                        child: Text(
                          "createAcc".tr(),
                          style:
                          Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 16,
                            decorationColor:
                            Theme.of(context).colorScheme.primary,
                            decorationThickness: 2,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  CustomSwitch(
                    onChange: (value) {
                      setState(() {
                        selectedLanguage = value;
                      });
                      if (selectedLanguage == 1) {
                        context.setLocale(const Locale("ar"));
                      } else {
                        context.setLocale(const Locale("en"));
                      }
                    },
                    icons: [
                      SvgPicture.asset(
                        AssetsManager.us,
                        height: 30,
                        width: 30,
                      ),
                      SvgPicture.asset(
                        AssetsManager.eg,
                        height: 30,
                        width: 30,
                      ),
                    ],
                    current: selectedLanguage,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
