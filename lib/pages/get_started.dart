// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:quickworks/pages/home_page.dart';
import 'package:quickworks/utils/colors.dart';
import 'package:quickworks/widget/button.dart';
import 'package:quickworks/widget/heading.dart';
import 'package:quickworks/widget/paragraph.dart';
import 'package:quickworks/widget/space.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Column(
        children: [
          Expanded(
              child: Center(
                  child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Image.asset("assets/images/get started.png"),
          ))),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      heading("Explore job opportunities, grow professionally",
                          textAlign: TextAlign.center),
                      space(),
                      paragraph(
                          "When you use our app to find freelancing jobs, you're not only gaining the freedom and flexibility that comes with freelancing, but you're also opening yourself up to new and exciting opportunities that can help you grow professionally.",
                          textAlign: TextAlign.center),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setBool(
                              "getStartedPageViewed", true);
                          Get.to(() => const HomePage());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: button("Get started"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
