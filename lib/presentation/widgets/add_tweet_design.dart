import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_ui/core/utils/controller.dart';
import 'package:twitter_ui/core/utils/details.dart';
import 'package:twitter_ui/data/repository/db_repository.dart';
import 'package:twitter_ui/domain/models/comments.dart';
import 'package:twitter_ui/domain/models/tweet_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:twitter_ui/presentation/providers/db_data_provider.dart';

class AddTweetDesign extends StatelessWidget {
  const AddTweetDesign(this.actionId, {super.key});
  final int actionId;
  // final DbRepo _dbRepo = DbRepo(DBHelper());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: addTweetFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          validator: (value) {
            if(value == null || value.isEmpty) {
              return "Write something";
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: actionId==0 ? addTweetController : addCommentController,
          minLines: 1,
          maxLines: 1000,
          autofocus: true,
          decoration: InputDecoration(
              isDense: true,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: CircleAvatar(
                  foregroundImage: AssetImage("assets/ME.jpg"),
                  backgroundColor: Colors.black,
                ),
              ),
              border: InputBorder.none,
              hintText: actionId == 0 ?  AppLocalizations.of(context)!.postHint : AppLocalizations.of(context)!.replyHint,
              hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }



  void addTweet(WidgetRef ref) async {
    DbRepo dbRepo = ref.watch(dbRepoProvider);
    if(addTweetFormKey.currentState!.validate()){
      TweetModel tweetModel = TweetModel(UniqueKey().hashCode, addTweetController.text, loggedInUser!, 0);
      dbRepo.addTweet(tweetModel);
      dbRepo.fetchProviderData(ref);
      addTweetController.text = "";
    }
  }

  void addComment(int id, WidgetRef ref) async {
    DbRepo dbRepo = ref.watch(dbRepoProvider);
    TweetModel? tweet = await dbRepo.getTweet(id);
    if(addTweetFormKey.currentState!.validate()){
      Comments comments = Comments(UniqueKey().hashCode, addCommentController.text, loggedInUser!, tweet!);
      dbRepo.addComment(comments);
      dbRepo.fetchProviderData(ref);
      addCommentController.text = "";
    }
  }
}
