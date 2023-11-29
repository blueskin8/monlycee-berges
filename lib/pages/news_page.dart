import 'package:flutter/material.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';
import 'package:monlycee/other/get_percentage.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  Future<void> initPage() async {

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mon lycée",
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        bottomNavigationBar: const BottomNavBar(),
        backgroundColor: const Color(0xff2A3961),
        body: FutureBuilder(
          future: initPage(),
          builder: (context, snapshot) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: getPercentage(context, "w90"),
                    child: Text(
                      "Cette page est en développement",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "FeixenVariable",
                          fontSize: getPercentage(context, "w10")
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
