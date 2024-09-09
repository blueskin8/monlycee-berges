import 'package:flutter/material.dart';
import 'package:monlycee/pages/settings_page.dart';
import 'package:monlycee/pages/home_page.dart';
import 'package:monlycee/pages/ent_page.dart';

class BottomNavBar extends StatelessWidget {
  final BuildContext context;
  const BottomNavBar({super.key, required this.context});

  @override
  Widget build(BuildContext currentContext) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
        ),
      ),
      child: BottomAppBar(
        color: const Color(0xff1f202e),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const HomePage()));
              },
            ),
            IconButton(
              icon: const ImageIcon(AssetImage("assets/entIcon.png"),
                  color: Colors.white),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const ENTPage()));
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const SettingsPage()));
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}