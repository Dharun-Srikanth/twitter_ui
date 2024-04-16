import 'package:flutter/material.dart';
import 'package:twitter_ui/presentation/widgets/about_design.dart';
import 'package:twitter_ui/presentation/widgets/bottom_nav.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("About", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
      ),
      body: const AboutDesign(),
      bottomNavigationBar: const BottomNavigation(),

    );
  }
}
