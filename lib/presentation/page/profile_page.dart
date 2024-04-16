import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_ui/presentation/page/app_launch_page.dart';
import 'package:twitter_ui/presentation/widgets/profile_design.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
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
              icon: const Icon(Icons.arrow_back),
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
                icon: const Icon(Icons.search),
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
      body: ProfilePageDesign(ref: ref),
    );
  }
}
