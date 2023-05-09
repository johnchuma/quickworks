import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickworks/models/job.dart';
import 'package:quickworks/utils/colors.dart';
import 'package:quickworks/widget/button.dart';
import 'package:quickworks/widget/form.dart';
import 'package:quickworks/widget/heading.dart';
import 'package:quickworks/widget/muted.dart';
import 'package:quickworks/widget/space.dart';

class PostJob extends StatefulWidget {
  const PostJob({super.key});

  @override
  State<PostJob> createState() => _PostJobState();
}

class _PostJobState extends State<PostJob> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController endingTimeController = TextEditingController();
  TextEditingController linkController = TextEditingController(text: "http://");
  TextEditingController phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Job job = Job();
  bool isDateSet = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      heading("Post new job",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ],
                  ),
                ],
              ),

              // const Spacer(),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 90,
                        width: double.infinity,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Form(
                            key: _formKey,
                            child: ListView(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              padding: const EdgeInsets.only(top: 0),
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        job
                                            .uploadImage()
                                            .then((value) => {setState(() {})});
                                      },
                                      child: Container(
                                        height: 80,
                                        color: Colors.grey[200],
                                        width: 100,
                                        // ignore: unnecessary_null_comparison
                                        child: job.path != ""
                                            ? Image.file(job.imageFile)
                                            : const Icon(Icons.add_a_photo),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          heading("Job poster image",
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                          muted(
                                              "This image can be a job poster or any image that explains your job visualy.")
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                space(),
                                form(titleController, "Job title"),
                                form(descriptionController, "Job description",
                                    maxLines: 5),
                                form(countryController, "Country"),
                                form(regionController, "Region"),
                                form(linkController,
                                    "Application link (optional)"),
                                form(phoneController, "Phone number",
                                    textInputType: TextInputType.phone),
                                space(),
                                heading("Expiring date",
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                GestureDetector(
                                  onTap: () async {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now()
                                                .add(const Duration(days: 30)))
                                        .then((value) {
                                      job.endingDate =
                                          Timestamp.fromDate(value!);
                                      setState(() {
                                        isDateSet = true;
                                      });
                                    });

                                    // Get.dialog(Center(
                                    //   child: Container(
                                    //     height: 400,
                                    //     child: DatePickerDialog(

                                    //             .add(Duration(days: 365))),
                                    //   ),
                                    // ));
                                  },
                                  child: Row(
                                    children: [
                                      isDateSet
                                          ? heading(
                                              "${job.endingDate.toDate()}",
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: primary)
                                          : heading(
                                              "Click here to set expiring date of this post",
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: primary)
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 100,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 20,
                right: 20,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: GestureDetector(
                        onTap: () {
                          if (job.path != "") {
                            if (_formKey.currentState!.validate()) {
                              job.title = titleController.text;
                              job.description = descriptionController.text;
                              job.country = countryController.text;
                              job.region = regionController.text;
                              job.phone = phoneController.text;
                              job.link = linkController.text;
                              job.postJob();
                            }
                          } else {
                            Get.snackbar(
                                backgroundColor: Colors.white,
                                "Can't post",
                                "You have to upload image");
                          }
                        },
                        child: button("Post")),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
