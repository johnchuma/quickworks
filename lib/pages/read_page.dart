// ignore_for_file: unnecessary_import, implementation_imports, unused_import, must_be_immutable, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:quickworks/controllers/dynamic_links.dart';
import 'package:quickworks/models/job.dart';
import 'package:quickworks/utils/colors.dart';
import 'package:quickworks/widget/button.dart';
import 'package:quickworks/widget/heading.dart';
import 'package:quickworks/widget/muted.dart';
import 'package:quickworks/widget/paragraph.dart';
import 'package:quickworks/widget/space.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadPage extends StatelessWidget {
  Job job;
  ReadPage(this.job, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: job.image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black])),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: ClipOval(
                            child: Container(
                              height: 40,
                              width: 40,
                              color: Colors.black.withOpacity(0.4),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        heading(job.title,
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                        space(size: 5),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                color: primary.withOpacity(0.7),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  child: paragraph(job.country,
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            muted(
                                "${Jiffy(job.startingDate.toDate()).fromNow()}",
                                color: Colors.white.withOpacity(0.8))
                          ],
                        ),
                        space(size: 40),
                      ],
                    ),
                  ),
                )),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                child: Container(
                  height: MediaQuery.of(context).size.height / 2 + 30,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        space(),
                        heading("Job description", fontSize: 15),
                        // space(),
                        paragraph(job.description),

                        GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse(job.link));
                          },
                          child: paragraph(job.link,
                              color: primary,
                              fontSize: 13,
                              textDecoration: TextDecoration.underline),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  shareLink(job);
                                },
                                child: paragraph("Share")),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: GestureDetector(
                                    onTap: () {
                                      launchUrl(Uri.parse("tel:${job.phone}"));
                                    },
                                    child: button("Call")))
                          ],
                        ),
                        space()
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
