import 'package:flutter/cupertino.dart';

class ForYouSection extends StatefulWidget {
  const ForYouSection({super.key});

  @override
  State<ForYouSection> createState() => _ForYouSectionState();
}

class _ForYouSectionState extends State<ForYouSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("For you"),
        Text("Following")
      ],
    );
  }
}
