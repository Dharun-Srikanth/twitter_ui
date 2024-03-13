import 'package:flutter/material.dart';
import 'package:twitter_ui/presentation/widgets/bottom_nav.dart';
import 'package:twitter_ui/presentation/widgets/notification_design.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Notification", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
      ),
      body: const NotificationDesign(),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
