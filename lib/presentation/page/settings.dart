import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_ui/core/utils/controller.dart';
import 'package:twitter_ui/presentation/page/app_launch_page.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 32,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: ListView(
            children: [
              const Text(
                "Data load",
                style: TextStyle(fontSize: 20),
              ),
              ListTile(
                leading: const Icon(Icons.data_saver_off_outlined),
                title: const Text("Load data from Database"),
                onTap: () {
                  ref.read(allTweetRiverpod).loadFromDB();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.data_saver_off_outlined),
                title: const Text("Load data from API"),
                onTap: () {
                  ref.read(allTweetRiverpod).loadFromAPI();
                  Navigator.pop(context);
                },
              ),
              Divider(),
              const Text(
                "Language",
                style: TextStyle(fontSize: 20),
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text("English"),
                onTap: () {
                  ref.read(langProvider).setEnglish();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text("French"),
                onTap: () {
                  ref.read(langProvider).setFrench();
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("LogOut"),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AppLaunchPage()),
                      (route) => false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
