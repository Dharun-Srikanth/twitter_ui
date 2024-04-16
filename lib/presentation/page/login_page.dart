import 'package:flutter/material.dart';
import 'package:twitter_ui/presentation/page/app_launch_page.dart';
import 'package:twitter_ui/presentation/widgets/login_page_design.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close_sharp, size: 32,),
          onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AppLaunchPage()), (route) => false);
          },
        ),
        title: Image.asset(
          'assets/twitter.png',
          width: 32.0,
          height: 32.0,
        ),
      ),
      body: const LoginPageDesign(),
    );
  }
}
