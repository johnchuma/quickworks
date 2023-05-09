import 'package:flutter/material.dart';
import 'package:quickworks/utils/colors.dart';
import 'package:quickworks/widget/heading.dart';

Widget form(TextEditingController controller, String title,
    {int? maxLines, TextInputType? textInputType}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      heading(title, fontSize: 15, fontWeight: FontWeight.normal),
      SizedBox(
        child: TextFormField(
          controller: controller,
          minLines: 1,
          maxLines: maxLines ?? 1,
          keyboardType: textInputType ?? TextInputType.text,
          validator: (value) {
            if (value == "") {
              return "This field can not be empty";
            }
            return null;
          },
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintStyle: const TextStyle(fontSize: 14),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: primary)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300)),
              focusColor: primary,
              fillColor: Colors.grey[300],
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              hintText: "Enter $title"),
        ),
      )
    ],
  );
}
