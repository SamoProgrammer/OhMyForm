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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Text("Recent forms"),
                    Row(children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 7,
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text('Form 1'),
                            Text('5 fields'),
                            Text('1939/8/1')
                          ],
                        ),
                      )
                    ])
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
