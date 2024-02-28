import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_ui/controller/language_controller.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Languages"),
            const Divider(),
            TextButton(onPressed: (){
              Get.find<LanguageController>().changeLang("en");
              Navigator.pop(context);
            },
                child: const Text("English")),
            TextButton(onPressed: (){
              Get.find<LanguageController>().changeLang("fr");
              Navigator.pop(context);
            },
                child: const Text("French")),

          ],
        ),
      ),
    );
  }
}
