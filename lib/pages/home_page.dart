// ignore_for_file: unnecessary_import, implementation_imports, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jiffy/jiffy.dart';
import 'package:quickworks/controllers/ads.dart';
import 'package:quickworks/controllers/job_controller.dart';
import 'package:quickworks/models/job.dart';
import 'package:quickworks/pages/post_job.dart';
import 'package:quickworks/utils/colors.dart';
import 'package:quickworks/widget/heading.dart';
import 'package:quickworks/widget/job.dart';
import 'package:quickworks/widget/muted.dart';
import 'package:quickworks/widget/paragraph.dart';
import 'package:quickworks/widget/space.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController keyword = TextEditingController();
  List<String> countries = [];
  List<String> regions = [];
  bool isSearch = true;

  @override
  Widget build(BuildContext context) {
    return GetX<JobController>(
        init: JobController(),
        builder: (find) {
          List<Job> jobs = find.jobs
              .where((job) =>
                  job.country
                      .toLowerCase()
                      .contains(keyword.text.toString().toLowerCase()) ||
                  job.region
                      .toLowerCase()
                      .contains(keyword.text.toString().toLowerCase()) ||
                  job.title
                      .toLowerCase()
                      .contains(keyword.text.toString().toLowerCase()))
              .toList();
          jobs = jobs.reversed.toList();
          Set<String> countriesSet = {"All country"};
          countries = [];
          for (var job in find.jobs) {
            countriesSet.add(job.country.capitalize!);
          }
          countries = countriesSet.toList();
          return Scaffold(
            backgroundColor: primary,
            floatingActionButton: FloatingActionButton(
              backgroundColor: primary,
              onPressed: () {
                Get.to(() => const PostJob());
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          space(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              heading("Quick jobs",
                                  color: Colors.white, fontSize: 14),
                            ],
                          ),
                          space(),
                          space(),
                          Row(
                            children: [
                              isSearch
                                  ? Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Center(
                                              child: TextFormField(
                                                onChanged: (value) =>
                                                    {setState(() => {})},
                                                controller: keyword,
                                                decoration: const InputDecoration(
                                                    hintStyle:
                                                        TextStyle(fontSize: 13),
                                                    hintText:
                                                        'Search title, country or region here',
                                                    border: InputBorder.none),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: DropdownButtonFormField(
                                            decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintStyle:
                                                    TextStyle(fontSize: 13),
                                                hintText: "Select country"),
                                            items: countries
                                                .map((e) => DropdownMenuItem(
                                                    value: e == "All country"
                                                        ? ""
                                                        : e,
                                                    child: paragraph(
                                                      e,
                                                    )))
                                                .toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                keyword.text = value!;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    )),
                              const SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSearch = !isSearch;
                                  });
                                },
                                child: isSearch
                                    ? const Icon(
                                        Icons.filter_alt_outlined,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.filter_alt_off_outlined,
                                        color: Colors.white,
                                      ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height - 140,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  space(),
                                  space(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      heading("Available jobs"),
                                      muted(
                                          "${find.jobs.where((job) => job.country.toLowerCase().contains(keyword.text.toString().toLowerCase()) || job.region.toLowerCase().contains(keyword.text.toString().toLowerCase()) || job.title.toLowerCase().contains(keyword.text.toString().toLowerCase())).length} Jobs")
                                    ],
                                  ),
                                  space(),
                                  Expanded(
                                      child: ListView.builder(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0),
                                          itemCount: jobs.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                job(jobs[index]),
                                                index % 4 == 0 && index != 0
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 10),
                                                        child: AdWidget(
                                                            ad: bannerAd()),
                                                      )
                                                    : Container()
                                              ],
                                            );
                                          })),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
