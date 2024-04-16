import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:twitter_ui/data/datasources/db/db_helper.dart';
import 'package:twitter_ui/presentation/page/add_tweet.dart';
import 'package:twitter_ui/presentation/page/app_launch_page.dart';
import 'package:twitter_ui/presentation/page/homepage.dart';
import 'package:twitter_ui/presentation/page/login_page.dart';
import 'package:twitter_ui/presentation/page/profile_page.dart';
import 'package:twitter_ui/presentation/page/register.dart';
import 'package:twitter_ui/presentation/page/settings.dart';
import 'package:twitter_ui/presentation/providers/data_controller.dart';
import 'package:twitter_ui/presentation/providers/language_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  if(kIsWeb){
    databaseFactory = databaseFactoryFfiWeb;
  }
  DBHelper();
  // db.database;

  Get.put(DataController());
  Get.put(LanguageController());

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales:AppLocalizations.supportedLocales,
      locale: Locale(ref.watch(langProvider).lang),
      routes: {
        "launchPage":(context) => const AppLaunchPage(),
        "register":(context) => RegisterPage(),
        "loginPage":(context) => const LoginPage(),
        "homepage":(context) => const HomePage(),
        "addTweet":(context) =>  const AddTweet(actionId: 0,),
        "profile":(context) => const ProfilePage(),
        "settings":(context) => const Settings(),
      },
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.dark,
      home: const AppLaunchPage(),
    );
  }
}
