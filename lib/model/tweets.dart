class Tweets{
  final int id;
  int userId;
  String tweet;
  int likes=0;
  List<String> comments=[];


  Tweets({required this.id, required this.userId, required this.tweet, required likes, required comments});

  factory Tweets.fromJson(Map<String, dynamic> json) {
    return Tweets(
      id: json['id'],
      userId: json['userId'],
      tweet: json['title']+"\n"+json['body'],
      likes: 0,
      comments: []
    );
  }
}
