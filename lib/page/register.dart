import 'package:flutter/material.dart';
import 'package:twitter_ui/widgets/register_design.dart';

import '../widgets/primary_button.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final registerFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final RegisterDesign registerDesign = RegisterDesign(registerFormkey: registerFormKey,);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close_sharp, size: 32,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Image.asset(
          'assets/twitter.png',
          width: 32.0,
          height: 32.0,
        ),
      ),
      body: RegisterDesign(registerFormkey: registerFormKey,),
      floatingActionButton:   PrimaryButton(
          title: "Create account",
          onPressed: () {
            registerDesign.saveData();
            Navigator.pushNamed(context, "loginPage");
          }),
    );
  }

}
