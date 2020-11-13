import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:swd_project/Components/Category/category_data.dart';
import 'package:swd_project/Components/Recommend/recommend_by_industry.dart';
import 'package:swd_project/Model/User/UserReview.dart';
import 'package:swd_project/Widget/load_and_error-process.dart';
import 'package:swd_project/Widget/slide_show.dart';

class homeContent extends StatefulWidget {
  @override
  _homeContentState createState() => _homeContentState();
}

class _homeContentState extends State<homeContent> {
  final _controller = ScrollController();
  final LocalStorage storage = LocalStorage('user');
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.07),
            offset: const Offset(4, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: ListView(
        controller: _controller,
        children: [
          SlideShow(),
          loadRecommend(),
          CategoryListIncludeProduct()
        ],
      ),
    );
  }

  Widget loadRecommend() {
    return FutureBuilder(
        future: storage.ready,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var user = User.fromJsonProfile(storage.getItem('user'));
            return RecommendForUser(
              userId: user.id,
            );
          } else if (snapshot.hasError) {
            return BuildError(
              error: snapshot.error,
            );
          } else {
            return BuildLoading();
          }
        });
  }
}