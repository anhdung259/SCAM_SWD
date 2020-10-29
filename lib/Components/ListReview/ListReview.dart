import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:swd_project/Model/ReviewList.dart';

import 'ReviewOfList.dart';

class ListReview extends StatefulWidget {
  final List<Review> reviews;

  const ListReview({Key key, this.reviews}) : super(key: key);

  @override
  _ListReviewState createState() => _ListReviewState(reviews);
}

class _ListReviewState extends State<ListReview> {
  final List<Review> reviews;

  _ListReviewState(this.reviews);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return SingleChildScrollView(
          // physics: ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    new BoxShadow(
                        color: Colors.black54.withOpacity(0.5),
                        offset: new Offset(1.0, 3.0),
                        blurRadius: 3.7),
                  ]),
              child: Column(
                children: [
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          new BoxShadow(
                              color: Colors.black54.withOpacity(0.1),
                              offset: new Offset(1.0, 3.0),
                              blurRadius: 3.7),
                        ]),
                    child: Row(
                      children: [
                        Container(
                          width: 65.0,
                          height: 65.0,
                          decoration: new BoxDecoration(
                            color: const Color(0xff7c94b6),
                            image: new DecorationImage(
                              image: new NetworkImage(
                                  reviews[index].user.avatarUrl),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(50.0)),
                            border: new Border.all(
                              color: Colors.green,
                              width: 2.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 30),
                          child: Text(
                            reviews[index].user.name,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    child: Stack(
                      children: [
                        ReviewOfMember(
                          reviewByUser: reviews[index].reviewAnswers,
                          rate: reviews[index].rate,
                          time: Jiffy(reviews[index].completeOn).yMMMMd,
                        ),
                      ],
                    ),
                  ),

                  // Expanded(
                  //   child: ListProduct(
                  //     productCategory: categories[index].productCategories,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
