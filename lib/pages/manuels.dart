import 'package:flutter/material.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';

class ManuelsPage extends StatefulWidget {
  const ManuelsPage({super.key});

  @override
  State<ManuelsPage> createState() => _ManuelsPageState();
}

class _ManuelsPageState extends State<ManuelsPage> {

  Future<void> initPage() async {

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mon lycée",
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        bottomNavigationBar: const BottomNavBar(),
        backgroundColor: Color(0xff2a3961),
        body: FutureBuilder(
          future: initPage(),
          builder: (context, snapshot) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [

                  ],
                )
              ],
            )
          },
        ),
      ),
    );
  }
}
