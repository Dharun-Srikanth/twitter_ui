import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_ui/core/utils/controller.dart';

class NotificationDesign extends ConsumerWidget {
  const NotificationDesign({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> notifications = ref.watch(allTweetRiverpod).notificationList;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: notifications.length,
      itemBuilder: (BuildContext context, int index) {
        if (index >= notifications.length) {
          return const Center(
            child: SizedBox(
              height: 24.0,
              width: 24,
              child: CircularProgressIndicator(),
            ),
          );
        }
        return notifyDesignLayout(notifications[index]);
      },

    );
  }

  Widget notifyDesignLayout(String value) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          const CircleAvatar(
            foregroundImage: AssetImage("assets/profile.png"),
          ),
          const SizedBox(width: 20,),
          Text(value, style: const TextStyle(fontSize: 18),)
        ],
      ),
    );
  }
}
