// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:quickworks/controllers/ads.dart';
import 'package:quickworks/models/job.dart';
import 'package:quickworks/pages/read_page.dart';
import 'package:quickworks/widget/heading.dart';
import 'package:quickworks/widget/muted.dart';
import 'package:quickworks/widget/space.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget job(Job job) {
  return GestureDetector(
    onTap: () {
      loadAds(() {
        Get.to(() => ReadPage(job));
      });
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                  width: 100,
                  height: 90,
                  child: CachedNetworkImage(
                    imageUrl: job.image,
                    fit: BoxFit.cover,
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heading(job.title,
                      fontSize: 14, maxLines: 2, fontWeight: FontWeight.normal),
                  Row(
                    children: [
                      muted("${job.country}, ${job.region}"),
                    ],
                  ),
                  muted(Jiffy(job.startingDate.toDate()).fromNow().toString()),
                ],
              ),
            )
          ],
        ),
        space(),
      ],
    ),
  );
}
