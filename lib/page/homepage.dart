import 'package:flutter/material.dart';
import 'package:hidable/hidable.dart';
import 'package:twitter_ui/constants/controller.dart';
import 'package:twitter_ui/page/add_tweet.dart';
import 'package:twitter_ui/widgets/bottom_nav.dart';
import 'package:twitter_ui/widgets/drawer_design.dart';
import 'package:twitter_ui/widgets/tweets_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  ScrollController hideScrollController = ScrollController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: const DrawerDesign(),
        appBar: Hidable(
          controller: hideScrollController,
          child: AppBar(
            centerTitle: true,
            leading: Builder(
              builder: (BuildContext context2){
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context2).openDrawer();
                  },
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    size: 32.0,
                  ),
                );
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "settings");
                  },
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                    size: 32.0,
                  ))
            ],
            title: Image.asset(
              "assets/twitter.png",
              width: 32.0,
            ),
          ),
        ),
        body: TweetsLayout(hideScrollController: hideScrollController),
        bottomNavigationBar: Hidable(
          controller: hideScrollController,
            preferredWidgetSize: Size.fromHeight(84),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: BottomNavigation(),
          )
        ),
        floatingActionButton: Hidable(
          controller: hideScrollController,
          child: Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 62.0,
              height: 62.0,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddTweet(actionId: 0)));
                },
                backgroundColor: Colors.blueAccent,
                shape: const CircleBorder(),
                child: const Icon(Icons.add, size: 32.0,),
              ),
            ),
          ),
        )
      ),
    );
  }
}
