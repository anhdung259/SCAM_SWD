import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:swd_project/Model/User.dart';

class Profile extends StatefulWidget {
  User user;
  Profile(this.user);
  @override
  State<StatefulWidget> createState() {
    return _ProfileState(user);
  }
}

class _ProfileState extends State<Profile> {
  final User user;
  _ProfileState(this.user);
  bool showOnlyCompleted = false;

  static const double _imageHeight = 256.0;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildTimeline(),
          _buildImage(),
          _buildTopHeader(),
          _buildProfileRow(),
          _buildBottomPart(),
        ],
      ),
    );
  }

  Widget _buildTopHeader() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 24.0),
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                child: Text(
                  "Thông tin cá nhân",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
            )
          ],
        ),
      );

  Widget _buildImage() => ClipPath(
        clipper: DialogonalClipper(),
        child: Container(
          width: double.infinity,
          child: Image.network(
            'https://www.stevegutzler.com/wp-content/uploads/2019/03/AdobeStock_218563918-1030x546.jpeg',
            fit: BoxFit.cover,
            height: _imageHeight,
            colorBlendMode: BlendMode.srcOver,
            color: Color.fromARGB(120, 20, 10, 40),
          ),
        ),
      );

  Widget _buildProfileRow() => Padding(
        padding: const EdgeInsets.only(top: _imageHeight / 2.5, left: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              minRadius: 28.0,
              maxRadius: 28.0,
              backgroundImage: NetworkImage(
                  'https://lh3.googleusercontent.com/-RKP8c-JJkAI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuckHjPgXynX3644QqCCa7Wd9DjJ4cQ/s96-c/photo.jpg'),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Đinh Hậu",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "FPT university",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w200),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );

  Widget _buildBottomPart() => Padding(
        padding: const EdgeInsets.only(top: _imageHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[_buildMyTaskHeader()],
        ),
      );

  Widget _buildMyTaskHeader() => Padding(
        padding: const EdgeInsets.only(left: 64.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Thông Tin',
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      );

  Widget _buildTimeline() => Positioned(
        top: 0.0,
        bottom: 0.0,
        left: 32.0,
        child: Container(
          width: 1.0,
          color: Colors.grey[300],
        ),
      );
}

class TaskRow extends StatelessWidget {
  final Animation<double> animation;
  final Task task;

  const TaskRow({Key key, this.task, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.5),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: task.color),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      task.name,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      task.category,
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  task.time,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DialogonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..lineTo(0.0, size.height - 60.0)
    ..lineTo(size.width, size.height)
    ..lineTo(size.width, 0.0)
    ..close();

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class Task {
  final String name;
  final String category;
  final String time;
  final Color color;
  final bool completed;

  Task({this.name, this.category, this.time, this.color, this.completed});
}

class ListModel {
  final GlobalKey<AnimatedListState> listKey;
  final List<Task> items;

  ListModel(this.listKey, items) : this.items = List.of(items);

  AnimatedListState get _animatedList => listKey.currentState;

  int get length => items.length;

  Task operator [](int index) => items[index];

  int indexOf(Task item) => items.indexOf(item);

  void insert(int index, Task item) {
    items.insert(index, item);
    _animatedList.insertItem(index);
  }

  Task removeAt(int index) {
    final Task removedItem = items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(index, (context, animation) => Container());
    }
    return removedItem;
  }
}
