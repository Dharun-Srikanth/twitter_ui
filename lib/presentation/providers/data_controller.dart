import 'package:get/get.dart';
import 'package:twitter_ui/core/utils/details.dart';
import 'package:twitter_ui/domain/models/tweet_details.dart';
import 'package:twitter_ui/domain/models/user_model.dart';

class DataController extends GetxController {
  RxList<TweetDetails> allTweetContent = <TweetDetails>[].obs;
  RxList<TweetDetails> currentUserTweets = <TweetDetails>[].obs;
  RxList<TweetDetails> currentUserLikedTweets = <TweetDetails>[].obs;
  RxList<TweetDetails> currentUserReplies = <TweetDetails>[].obs;
  RxList<UserModel> allUsers = <UserModel>[].obs;
  RxList<UserModel> filteredUsers = <UserModel>[].obs;

  void setData() async {
    allTweetContent.value = await constDbHelper.getAllDetails();
    update();
  }

  void setUserTweet() async {
    currentUserTweets.value = allTweetContent.where((element) => element.userDetails.id==loggedInUser!.id).toList();
    update();
  }

  void setUserLikedTweet() async {
    currentUserLikedTweets.value = allTweetContent.where((element) => element.userDetails.id==loggedInUser!.id && element.isLiked).toList();
    update();
  }

  void setUserReplies() async {
    currentUserReplies.value = allTweetContent.where((element) => element.userDetails.id==loggedInUser!.id && element.comments.isNotEmpty).toList();
    update();
  }

  void setUsers() async {
    allUsers.value = await constDbHelper.getUsers();
    update();
  }

  void setFilteredUsers() {
    filteredUsers.value = allUsers;
  }

  void filterUsers(String query) {
    filteredUsers.value = allUsers
          .where((element) =>
          element.username.toLowerCase().contains(query.toLowerCase()))
          .toList();
    update();
  }
}