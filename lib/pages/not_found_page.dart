import 'package:flutter/material.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key});

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 175, 240, 228),
      body: Center(
          child: Column(
        children: [
          Image(
            image: AssetImage("assets/404.gif"),
          ),
          Text(
            "صفحه مورد نظر پیدا نشد",
            style: TextStyle(
                fontSize: 30, color: Color.fromARGB(255, 41, 128, 108)),
          )
        ],
      )),
    );
  }
}
