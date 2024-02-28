import 'package:flutter/material.dart';
import 'package:twitter_ui/widgets/register_design.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: RegisterDesign(),
    );
  }
}
