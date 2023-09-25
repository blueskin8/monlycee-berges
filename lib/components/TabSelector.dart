import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import '../pages/HomePage.dart';
import '../pages/PassPage.dart';
import '../pages/SettingsPage.dart';
import '../pages/EntPage.dart';
import '../pages/TurboselfPage.dart';

class MyHomePageState extends State<Home> with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "Pass'Région",
        useSafeArea: true,
        labels: const [
          "Pass'Région",
          "PassPage",
          "ENT",
          "Turboself",
          "Paramètres"
        ],
        icons: const [
          Icons.credit_card,
          Icons.credit_score,
          Icons.open_in_browser,
          Icons.restaurant,
          Icons.settings
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.white,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.blue[900],
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.indigo[400],
        onTabItemSelected: (int value) {
          setState(() {
            _motionTabBarController!.index = value;
          });
        },
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _motionTabBarController,
        children: <Widget>[
          MainPageContentComponent(
              title: "Emulation du Pass'Région en cours",
              controller: _motionTabBarController!),
          PassPage(),
          ENTPage(),
          TurboselfPage(),
          SettingsPage(),
        ],
      ),
    );
  }
}

class MainPageContentComponent extends StatelessWidget {
  const MainPageContentComponent({
    required this.title,
    required this.controller,
    Key? key,
  }) : super(key: key);

  final String title;
  final MotionTabBarController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 50),
            const Text(
                'Bah c\'est une page ça frero, t\'as pas besoin de description pour savoir que c\'est une page'),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
