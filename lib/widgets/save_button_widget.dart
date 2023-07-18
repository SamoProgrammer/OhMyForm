import 'package:flutter/material.dart';

class SaveButtonWidget extends StatefulWidget {
  final String text;
  final void Function() onPressed;

  const SaveButtonWidget(
      {super.key, required this.text, required this.onPressed});

  @override
  State<SaveButtonWidget> createState() => _SaveButtonWidgetState();
}

class _SaveButtonWidgetState extends State<SaveButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Colors.yellow[700], // Set the background color to yellow
        foregroundColor: Colors.black, // Set the text color to black
        minimumSize: const Size(40, 32), // Set the minimum size of the button
        padding: const EdgeInsets.symmetric(
            horizontal: 16), // Add horizontal padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), // Apply border radius
          side: BorderSide(color: Colors.yellow[700]!), // Add border color
        ),
      ),
      child: Text(
        widget.text,
        style: const TextStyle(fontSize: 14), // Set the font size of the text
      ),
    );
  }
}
