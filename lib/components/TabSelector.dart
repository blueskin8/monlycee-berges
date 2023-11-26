import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import '../pages/HomePage.dart';
import '../pages/PassPage.dart';
import '../pages/SettingsPage.dart';
import '../pages/EntPage.dart';
import '../pages/TurboselfPage.dart';

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
