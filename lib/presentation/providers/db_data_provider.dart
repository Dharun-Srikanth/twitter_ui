// Riverpod Controller
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_ui/data/datasources/db/db_helper.dart';
import 'package:twitter_ui/data/repository/db_repository.dart';

final allTweetProvider = FutureProvider((ref) async {
  final repository = ref.read(dbRepoProvider);
  return repository.getAllDetails();
});

final dbRepoProvider = Provider<DbRepo>((ref) {
  return DbRepo(DBHelper());
});