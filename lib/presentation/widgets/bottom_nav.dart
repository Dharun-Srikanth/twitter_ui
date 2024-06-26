import 'package:flutter/material.dart';
import 'package:twitter_ui/presentation/page/homepage.dart';
import 'package:twitter_ui/presentation/page/about.dart';
import 'package:twitter_ui/presentation/page/notification.dart';
import 'package:twitter_ui/presentation/page/search_page.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: BottomNavigationBar(
        // currentIndex: index,
        onTap: (int newIndex) {},
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false);
              },
              icon: const Icon(
                Icons.home_filled,
                size: 32.0,
                color: Colors.white,
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPage()),
                      (route) => false);
                },
                icon: const Icon(
                  Icons.search,
                  size: 32.0,
                  color: Colors.white,
                ),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationPage()),
                      (route) => false);
                },
                icon: const Icon(
                  Icons.notifications_outlined,
                  size: 32.0,
                  color: Colors.white,
                ),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutPage()),
                          (route) => false);
                },
                icon: const Icon(
                  Icons.info_outline_rounded,
                  size: 32.0,
                  color: Colors.white,
                ),
              ),
              label: ""),
        ],
      ),
    );
  }
}
