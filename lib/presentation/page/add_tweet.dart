import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_ui/presentation/widgets/add_tweet_design.dart';
import 'package:twitter_ui/presentation/widgets/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTweet extends ConsumerWidget {
  const AddTweet({super.key, required this.actionId});

  final int actionId;
  final AddTweetDesign addTweetDesign = const AddTweetDesign(1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close_sharp,
            size: 32,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PrimaryButton(
                title: actionId == 0 ? AppLocalizations.of(context)!.post : AppLocalizations.of(context)!.reply,
                onPressed: () {
                  if (actionId == 0) {
                    addTweetDesign.addTweet(ref);
                  } else {
                    addTweetDesign.addComment(actionId, ref);
                  }
                  Navigator.pop(context);
                }),
          )
        ],
      ),
      body: AddTweetDesign(actionId),
    );
  }
}
