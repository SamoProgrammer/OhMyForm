import 'package:flutter/material.dart';

class EditFormPage extends StatefulWidget {
  const EditFormPage({super.key});

  @override
  State<EditFormPage> createState() => _EditFormPageState();
}

class _EditFormPageState extends State<EditFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height,
              child: Column()),
          Expanded(child: Column())
        ],
      ),
    );
  }
}
