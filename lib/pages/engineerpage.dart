import 'package:flutter/material.dart';

class EngineerPage extends StatefulWidget {
  const EngineerPage({Key? key}) : super(key: key);

  @override
  State<EngineerPage> createState() => _EngineerPageState();
}

class _EngineerPageState extends State<EngineerPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Engineer Page"));
  }
}