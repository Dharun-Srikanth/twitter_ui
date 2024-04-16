import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:twitter_ui/domain/models/user_model.dart';
import 'package:twitter_ui/presentation/widgets/register_design.dart';

import '../widgets/primary_button.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final RegisterDesign registerDesign = RegisterDesign(
      registerFormKey: registerFormKey,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.close_sharp,
            size: 32,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Image.asset(
          'assets/twitter.png',
          width: 32.0,
          height: 32.0,
        ),
      ),
      body: RegisterDesign(
        registerFormKey: registerFormKey,
      ),
      floatingActionButton: PrimaryButton(
          title: "Create account",
          onPressed: () async {
            UserModel? user = await registerDesign.saveData();
            if (user != null) {
              if (context.mounted) {
                Navigator.pushNamed(context, "loginPage");
              }
            } else {
              if (context.mounted) {
                toastification.show(
                    context: context,
                    type: ToastificationType.error,
                    style: ToastificationStyle.minimal,
                    autoCloseDuration: const Duration(seconds: 5),
                    title: const Text("All fields must be filled"),
                    description: const Text("Check and fill your details"));
              }
            }
          }),
    );
  }
}
