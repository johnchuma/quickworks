import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickworks/controllers/file_picker.dart';
import 'package:quickworks/controllers/job_controller.dart';

class Job {
  late Timestamp startingDate;
  late Timestamp endingDate = Timestamp.now();
  late String title;
  late String image;
  late String description;
  late String phone;
  late String link;
  late String country;
  late String region;
  late String path = "";
  late File imageFile;
  Future uploadImage() async {
    await pickImages().then((value) {
      imageFile = value.first;
      path = value.first.path;
    });
  }

  void postJob() {
    JobController().uploadJob(this);
  }

  Job();
  Job.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    startingDate = documentSnapshot['startingDate'];
    endingDate = documentSnapshot['endingDate'];
    image = documentSnapshot['image'];
    title = documentSnapshot['title'];
    description = documentSnapshot['description'];
    phone = documentSnapshot['phone'];
    link = documentSnapshot['link'];
    country = documentSnapshot['country'];
    region = documentSnapshot['region'];
  }
}
