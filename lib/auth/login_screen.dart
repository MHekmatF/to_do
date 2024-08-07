import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:to_do/tabs/settings/settings_provider.dart';

import '../firebase_utils.dart';
import '../home_screen.dart';
import '../tabs/tasks/default_elevated_button.dart';
import '../tabs/tasks/default_text_form_field.dart';
import '../theme.dart';
import 'register_screen.dart';
import 'user_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: settingsProvider.themeMode == ThemeMode.dark
          ? AppTheme.backgroundColorDark
          : AppTheme.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context)!.login,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: AppTheme.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.png"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                AppLocalizations.of(context)!.welcome,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 16,
                ),
                DefaultTextFormField(
                  labelText:                 AppLocalizations.of(context)!.email,
                  controller: emailController,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return                 AppLocalizations.of(context)!.emailVal;

                  }
                    return null;
                  },
                ),
                DefaultTextFormField(
                  labelText:                 AppLocalizations.of(context)!.password,

                  validator: (p1) {
                    if (p1 == null || p1.isEmpty) {
                      return  AppLocalizations.of(context)!.passwordVal;
                    } else if (p1.length < 6) {
                      return AppLocalizations.of(context)!.charcterVal;
                    }
                    return null;
                  },
                  controller: passwordController,
                  isPassword: true,
                ),
                SizedBox(
                  height: 16.h,
                ),
                DefaultElevatedButton(
                    onPress: login,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: Text(
                              AppLocalizations.of(context)!.login,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: AppTheme.white, fontSize: 20.sp),
                          ),
                        ),
                        const Spacer(
                          flex: 8,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: AppTheme.white,
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20.h,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(RegisterScreen.routeName);
                    },
                    child: Text(
                        AppLocalizations.of(context)!.createNewAccount,

                        style: TextStyle(
                       color:  settingsProvider.themeMode == ThemeMode.dark
                            ? AppTheme.white
                            : AppTheme.black,
                      fontSize: 20,fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState?.validate() == true) {
      FirebaseUtils.logIn(
        email: emailController.text,
        password: passwordController.text,
      ).then((user) {
        Provider.of<UserProvider>(context, listen: false).updateUser(user);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }).catchError((error) {
        if (error is FirebaseAuthException && error.message != null) {
          Fluttertoast.showToast(
              msg: error.message!, toastLength: Toast.LENGTH_LONG);
        } else {
          Fluttertoast.showToast(
              msg: 'something went wrong $error',
              toastLength: Toast.LENGTH_LONG);
        }
      });
    }
  }
}
