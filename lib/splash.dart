import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Aristide Bergès',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
        ),
      ),
    );
  }
}