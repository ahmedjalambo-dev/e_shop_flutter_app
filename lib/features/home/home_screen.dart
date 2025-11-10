import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String firstName;
  const HomeScreen({super.key, required this.firstName});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Home Screen')));
  }
}
