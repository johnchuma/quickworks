// ignore_for_file: body_might_complete_normally_catch_error, avoid_print, duplicate_ignore

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quickworks/utils/colors.dart';
import '../models/job.dart';

class JobController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  Rx<List<Job>> jobsReceiver = Rx<List<Job>>([]);
  List<Job> get jobs => jobsReceiver.value;

  Stream<List<Job>> getJobs() {
    return firestore
        .collection("Jobs")
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Job> jobs = [];
      for (var element in querySnapshot.docs) {
        jobs.add(Job.fromDocumentSnapshot(element));
      }
      return jobs;
    });
  }

  @override
  void onInit() {
    jobsReceiver.bindStream(getJobs());
    super.onInit();
  }

  void uploadJob(Job job) async {
    Get.defaultDialog(
        title: "Uploading...",
        content: CircularProgressIndicator(
          color: primary,
        ));
    Timestamp timestamp = Timestamp.now();
    String id = timestamp.toDate().toString();
    var image = "";
    await getImageLinks(job.imageFile).then((value) => image = value);
    await firestore.collection("Jobs").doc(id).set({
      "id": id,
      "image": image,
      "startingDate": Timestamp.now(),
      "endingDate": job.endingDate,
      "title": job.title,
      "description": job.description,
      "country": job.country,
      "region": job.region,
      "phone": job.phone,
      "link": job.link == "http://" ? "" : job.link,
    }).catchError((err) {
      // print(err);
      Get.back();
    });
    Get.back();
    Get.back();
  }

  Future<String> getImageLinks(File file) async {
    String url = "";
    String fileName = file.path.split('/').last;
    // print(randomWord);
    print("Here");
    print(fileName);
    await storage
        .ref()
        .child("Jobs")
        .child(fileName)
        .putFile(file)
        .catchError((error) {});
    await storage
        .ref()
        .child("Jobs")
        .child(fileName)
        .getDownloadURL()
        .then((value) {
      url = value;
      // ignore: avoid_print, invalid_return_type_for_catch_error
    }).catchError((err) => print(err));
    return url;
  }
}
