import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.title, required this.onPressed});
  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        )),
        backgroundColor:
        MaterialStateProperty.all(Colors.blueAccent),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
