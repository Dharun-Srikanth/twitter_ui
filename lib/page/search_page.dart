import 'package:flutter/material.dart';
import 'package:hidable/hidable.dart';
import 'package:twitter_ui/constants/controller.dart';
import 'package:twitter_ui/widgets/bottom_nav.dart';
import 'package:twitter_ui/widgets/drawer_design.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: TextField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              filled: true,
              fillColor: Colors.grey.shade800,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50)
              ),
              hintText: "Search X",
              hintStyle: TextStyle(color: Colors.grey)
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
