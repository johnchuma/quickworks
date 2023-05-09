// ignore_for_file: deprecated_member_use

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickworks/pages/way_page.dart';
import 'package:quickworks/utils/colors.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quick jobs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          focusColor: primary,
          backgroundColor: primary,
          scaffoldBackgroundColor: primary,
          primaryColor: primary,
          textTheme: GoogleFonts.poppinsTextTheme()),
      home: const WayPage(),
    );
  }
}
