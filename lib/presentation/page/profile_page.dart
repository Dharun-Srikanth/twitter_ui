import 'package:flutter/material.dart';
import 'package:twitter_ui/presentation/page/app_launch_page.dart';
import 'package:twitter_ui/presentation/widgets/profile_design.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        backgroundColor: Colors.blue,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            // radius: 100,
            backgroundColor: Colors.black38,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              // radius: 100,
              backgroundColor: Colors.black38,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              // radius: 100,
              backgroundColor: Colors.black38,
              child: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AppLaunchPage()), (route) => false);
                },
                icon: const Icon(Icons.logout,),
              ),
            ),
          ),
        ],
      ),
      body: ProfilePageDesign(),
    );
  }
}
