import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:twitter_ui/controller/data_controller.dart';
import 'package:twitter_ui/controller/language_controller.dart';
import 'package:twitter_ui/page/add_tweet.dart';
import 'package:twitter_ui/page/homepage.dart';
import 'package:twitter_ui/page/app_launch_page.dart';
import 'package:twitter_ui/page/login_page.dart';
import 'package:twitter_ui/page/profile_page.dart';
import 'package:twitter_ui/page/register.dart';
import 'package:twitter_ui/page/settings.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'db/db_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  if(kIsWeb){
    databaseFactory = databaseFactoryFfiWeb;
  }
  DBHelper db = DBHelper();
  db.database;

  Get.put(DataController());
  Get.put(LanguageController());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    print(Get.find<LanguageController>().language.value);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales:AppLocalizations.supportedLocales,
      locale: Locale(Get.find<LanguageController>().language.value),
      routes: {
        "launchPage":(context) => const AppLaunchPage(),
        "register":(context) => RegisterPage(),
        "loginPage":(context) => const LoginPage(),
        "homepage":(context) => const HomePage(),
        "addTweet":(context) =>  AddTweet(actionId: 0,),
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
