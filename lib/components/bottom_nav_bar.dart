import 'package:flutter/material.dart';
import 'package:monlycee/pages/pass_page.dart';
import 'package:monlycee/pages/settings_page.dart';
import 'package:monlycee/pages/turboself_page.dart';
import 'package:monlycee/pages/home_page.dart';
import 'package:monlycee/pages/ent_page.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xff43497D),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const HomePage()
                  )
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_card, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => PassPage()
                  )
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.open_in_browser, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => ENTPage()
                  )
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.flatware, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => TurboselfPage()
                  )
              );
            },
          ),
          // IconButton(
          //   icon: const Icon(Icons.functions, color: Colors.white),
          //   onPressed: () {
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => SettingsPage()
                  )
              );
            },
          ),
        ],
      ),
    );
  }
}