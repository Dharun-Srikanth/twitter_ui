import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:twitter_ui/presentation/widgets/bottom_nav.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Inbox", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Lottie.asset(
          "assets/inbox.json"
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),

    );
  }
}
