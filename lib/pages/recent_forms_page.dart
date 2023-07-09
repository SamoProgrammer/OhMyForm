import 'package:flutter/material.dart';

class RecentFormsPage extends StatefulWidget {
  const RecentFormsPage({super.key});

  @override
  State<RecentFormsPage> createState() => _RecentFormsPageState();
}

class _RecentFormsPageState extends State<RecentFormsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 6,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                child: const Text("Create Form"),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 232, 255, 255),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      children: [const Text("Recent forms")],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
