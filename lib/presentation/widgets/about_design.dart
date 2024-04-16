import 'package:flutter/material.dart';

class AboutDesign extends StatelessWidget {
  const AboutDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "📱 Twitter UI Project",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              textAlign: TextAlign.center,
            ),
            Divider(),
            Text(
                "Twitter UI project has been developed using Flutter. The moto of the project is to develop an app which resembles 'Twitter Pages' by covering most of the topics covered in Flutter App Development such as State Management, API calls, Database, Localization."
            ,style: TextStyle(fontSize: 18), textAlign: TextAlign.justify,),
            Divider(),
            Text(
              "💡 App Features",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              textAlign: TextAlign.left,
            ),
            Divider(),
            Text("\u2022 Create and login to their account \n"
                "\u2022 Add, Edit, & Delete the tweets \n"
                "\u2022 Like & Comment to other's tweets \n"
                "\u2022 Share the tweets via other apps \n"
                "\u2022 Change app language \n"
                "\u2022 Load dummy data through API \n", style: TextStyle(fontSize: 18),),
            Divider(),
            Text(
              "📘 Concepts Covered",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              textAlign: TextAlign.left,
            ),
            Divider(),
            Text("\u2022 State Management \n"
                "\u2022 Database \n"
                "\u2022 API calls \n"
                "\u2022 Localization \n"
                "\u2022 Clean Architecture \n", style: TextStyle(fontSize: 18),),
            Divider(),
            Center(child: Text("💎 Developed by Dharun 💎", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }
}
