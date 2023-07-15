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
          SizedBox(
            height: MediaQuery.of(context).size.height / 7,
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: FractionalOffset.centerRight,
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: const Text("ایجاد فرم"),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Text("فرم های اخیر"),
                    Row(children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 7,
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text('فرم ثبت نام'),
                            Text('۵ فیلد'),
                            Text('۱۴۰۲/۱۰/۱۲')
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
