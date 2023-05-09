import 'package:flutter/material.dart';
import 'package:quickworks/utils/colors.dart';
import 'package:quickworks/widget/paragraph.dart';

Widget button(String text, {double? height}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: Container(
      width: double.infinity,
      color: primary,
      height: height ?? 50,
      child: Center(child: paragraph(text, color: Colors.white)),
    ),
  );
}
