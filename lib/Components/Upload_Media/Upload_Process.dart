import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swd_project/Bloc/Upload/Upload_Media_Bloc.dart';
class UploadFile extends StatelessWidget {
  UploadFile({Key key, this.file, this.task}) : super(key: key);

  final File file;
  final StorageUploadTask task;

  String status(task) {
    String result;
    if (task.isComplete) {
      if (task.isSuccessful) {
        result = 'complete';
      } else if (task.isCanceled) {
        result = 'Canceled';
      } else {
        result = 'Failed ERROR: ${task.lastSnapshot.error}';
      }
    } else if (task.isInProgress) {
      result = 'Uploading';
    } else if (task.isPaused) {
      result = 'Paused';
    }
    return result;
  }

  double _percentageTransferred(StorageTaskSnapshot snapshot) {
    return (snapshot.bytesTransferred / snapshot.totalByteCount * 100).floor() /
        100;
  }

  @override
  Widget build(BuildContext context) {
    String name = file.path.split('/').last;
    return StreamBuilder(
      stream: task.events,
      builder: (BuildContext context,
          AsyncSnapshot<StorageTaskEvent> asyncSnapshot) {
        Widget subtitle;
        if (asyncSnapshot.hasData) {
          final StorageTaskEvent event = asyncSnapshot.data;
          final StorageTaskSnapshot snapshot = event.snapshot;
          subtitle =
          //Text('${status(task)}: ${_percentageTransferred(snapshot)}');
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width - 80,
            animation: true,
            lineHeight: 20.0,
            percent: _percentageTransferred(snapshot),
            center: Text('${status(task)}: ${_percentageTransferred(snapshot)*100} %'),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: Colors.greenAccent,
          );
        } else {
          subtitle = const Text('Starting...');
        }
        return Column(
          children: [
            Container(
              key: Key(task.hashCode.toString()),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  subtitle,
                  SizedBox(height: 5,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Offstage(
                        offstage: !task.isInProgress,
                        child: IconButton(
                          icon: const Icon(Icons.pause),
                          onPressed: () => task.pause(),
                        ),
                      ),
                      Offstage(
                        offstage: !task.isPaused,
                        child: IconButton(
                          icon: const Icon(Icons.file_upload),
                          onPressed: () => task.resume(),
                        ),
                      ),
                      Offstage(
                        offstage: task.isComplete,
                        child: IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () => task.cancel(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}