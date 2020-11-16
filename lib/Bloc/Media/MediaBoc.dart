import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:swd_project/Components/DetailProduct/media_process.dart';
import 'package:swd_project/Model/User/UserReview.dart';

final StorageReference ref = FirebaseStorage.instance.ref();
final LocalStorage _localStorage = LocalStorage('user');

Future<Widget> fetchImages(StorageUploadTask task) async {
  String url = await task.lastSnapshot.ref.getDownloadURL();
  return Padding(padding: EdgeInsets.all(8.0), child: Text('$url'));
}

Future<String> getLinkLocation(StorageUploadTask task) async {
  String url = await task.lastSnapshot.ref.getDownloadURL();
  return url;
}

Future<Widget> uploadImages(File file, List<StorageUploadTask> _tasks) async {
  String name;
  name = file.path.split('/').last;
  StorageUploadTask task = ref
      .child('${User.fromJsonProfile(_localStorage.getItem('user')).id}/$name')
      .putFile(file);
  _tasks.add(task);
  return UploadFile(
    file: file,
    task: task,
  );
}
