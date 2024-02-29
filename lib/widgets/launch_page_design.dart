import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LaunchPageDesign extends StatelessWidget {
  const LaunchPageDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 100.0,
          ),
           Text(
            AppLocalizations.of(context)!.launch_title,
            style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 200.0,
          ),
          SignInButton(
            Buttons.google,
            onPressed: () {},
            text: AppLocalizations.of(context)!.o_auth_google,
            padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 0.5,
                  color: Colors.grey,
                  width: 130,
                ),
                SizedBox(width: 10,),
                Text("or"),
                SizedBox(width: 10,),
                Container(
                  height: 0.5,
                  color: Colors.grey,
                  width: 130,
                ),
              ],
            ),
          ),
          SignInButtonBuilder(
            onPressed: () {
              Navigator.pushNamed(context, "register");
            },
            text: AppLocalizations.of(context)!.create_account,
            textColor: Colors.black,
            fontSize: 16,
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 30,),
          RichText(text: TextSpan(
              children: [
                TextSpan(
                    text: AppLocalizations.of(context)!.terms,
                    style: TextStyle(color: Colors.grey)
                ),
                TextSpan(
                  text: AppLocalizations.of(context)!.terms_link,
                  style: TextStyle(color: Colors.blueAccent),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {},
                )
              ]
          )),
          SizedBox(height: 20,),
          RichText(text: TextSpan(
              children: [
                TextSpan(
                    text: AppLocalizations.of(context)!.login_message,
                    style: TextStyle(color: Colors.grey)
                ),
                TextSpan(
                    text: AppLocalizations.of(context)!.login_link,
                    style: TextStyle(color: Colors.blueAccent),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, "loginPage");
                      }
                )
              ]
          ))
        ],
      ),
    );
  }
}
