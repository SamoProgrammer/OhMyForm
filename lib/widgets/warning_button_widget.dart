import 'package:flutter/material.dart';

class WarningButtonWidget extends StatefulWidget {
  final String text;
  final void Function() onPressed;

  const WarningButtonWidget(
      {super.key, required this.text, required this.onPressed});

  @override
  State<WarningButtonWidget> createState() => _WarningButtonWidgetState();
}

class _WarningButtonWidgetState extends State<WarningButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Colors.yellow[700], // Set the background color to yellow
        foregroundColor: Colors.white, // Set the text color to black
        minimumSize: const Size(40, 32), // Set the minimum size of the button
        padding: const EdgeInsets.symmetric(
            horizontal: 24, vertical: 15), // Add horizontal padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), // Apply border radius
          side: BorderSide(
              color: Colors.yellow[800]!, width: 0.5), // Add border color
        ),
      ),
      child: Text(
        widget.text,
        style: const TextStyle(fontSize: 14), // Set the font size of the text
      ),
    );
  }
}
