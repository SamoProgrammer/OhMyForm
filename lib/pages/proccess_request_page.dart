import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class ProccessRequestPage extends StatefulWidget {
  final String url;
  const ProccessRequestPage({super.key, required this.url});

  @override
  State<ProccessRequestPage> createState() => _ProccessRequestPageState();
}

class _ProccessRequestPageState extends State<ProccessRequestPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Beamer.of(context).beamToNamed(Uri.decodeComponent(widget.url));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CircularProgressIndicator(),
    );
  }
}
