// ignore_for_file: unnecessary_import, implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quickworks/pages/get_started.dart';
import 'package:quickworks/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WayPage extends StatelessWidget {
  const WayPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> isGetStartedPageViewed() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool("getStartedPageViewed") == null ? false : true;
    }

    return FutureBuilder(
        future: isGetStartedPageViewed(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool value = snapshot.requireData;
            if (value) {
              return const HomePage();
            } else {
              return const GetStarted();
            }
          }
          return Container();
        });
  }
}
