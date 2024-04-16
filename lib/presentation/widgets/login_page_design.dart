import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:twitter_ui/core/utils/details.dart';
import 'package:twitter_ui/core/utils/regex.dart';
import 'package:twitter_ui/data/datasources/db/db_helper.dart';
import 'package:twitter_ui/data/repository/db_repository.dart';
import 'package:twitter_ui/presentation/page/homepage.dart';
import 'package:twitter_ui/presentation/widgets/primary_button.dart';

class LoginPageDesign extends StatefulWidget {
  const LoginPageDesign({super.key});

  @override
  State<LoginPageDesign> createState() => _LoginPageDesignState();
}

class _LoginPageDesignState extends State<LoginPageDesign> {
  final loginFormKey = GlobalKey<FormState>();
  bool _isNextClicked = false;
  bool _isPasswordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final DbRepo _dbRepo = DbRepo(DBHelper());

  loginAuthenticator(String username, String password) async {
    loggedInUser = await _dbRepo.login(username, password);
    if (loggedInUser != null) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
      }
    } else {
      if (mounted) {
        toastification.show(
            context: context,
            type: ToastificationType.error,
            style: ToastificationStyle.minimal,
            autoCloseDuration: const Duration(seconds: 5),
            title: const Text("User not found!"),
            description: const Text("Username or Password wrong."));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Form(
        key: loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!_isNextClicked)
                    Text(
                      AppLocalizations.of(context)!.cred_message,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                    )
                  else
                    Text(
                      AppLocalizations.of(context)!.pass_message,
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field cannot be empty";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.username_hint,
                        focusColor: Colors.blueAccent,
                        contentPadding: const EdgeInsets.all(25),
                        labelStyle:
                            const TextStyle(fontSize: 20, color: Colors.grey)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (_isNextClicked)
                    TextFormField(
                      autofocus: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This Field cannot be empty";
                        } else if (!(passwordRegExp.hasMatch(value))) {
                          return "Invalid password";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: IconButton(
                              icon: Icon(_isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          border: const OutlineInputBorder(),
                          labelText: AppLocalizations.of(context)!.password,
                          focusColor: Colors.blueAccent,
                          contentPadding: const EdgeInsets.all(25),
                          labelStyle: const TextStyle(
                              fontSize: 20, color: Colors.grey)),
                    ),
                ],
              ),
            ),
            Container(
              height: 60,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  border: Border(
                      top:
                          BorderSide(color: Colors.grey.shade800, width: 0.5))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Text(
                          AppLocalizations.of(context)!.forget,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    if (!_isNextClicked)
                      PrimaryButton(
                          title: AppLocalizations.of(context)!.next,
                          onPressed: () {
                            setState(() {
                              _isNextClicked = true;
                            });
                          })
                    else
                      PrimaryButton(
                          title: AppLocalizations.of(context)!.login_link,
                          onPressed: () => {
                                loginAuthenticator(emailController.text,
                                    passwordController.text)
                              })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
