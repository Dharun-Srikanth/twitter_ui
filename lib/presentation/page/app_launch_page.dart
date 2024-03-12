import 'package:flutter/material.dart';
import 'package:twitter_ui/presentation/widgets/launch_page_design.dart';

class AppLaunchPage extends StatelessWidget {
  const AppLaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/twitter.png',
          width: 32.0,
          height: 32.0,
        ),
      ),
      body: const LaunchPageDesign()
    );
  }
}
