import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/get_Review_Bloc.dart';
import 'package:swd_project/Components/ReviewProduct/load_review_update.dart';
import 'package:swd_project/Model/Product/Product.dart';
import 'package:swd_project/Model/ReviewAnswer/ReviewUpdateResponse.dart';

class UpdateReviewPage extends StatefulWidget {
  final Product product;
  const UpdateReviewPage({Key key, this.product}) : super(key: key);

  @override
  _UpdateReviewPageState createState() => _UpdateReviewPageState(product);
}

class _UpdateReviewPageState extends State<UpdateReviewPage> {
  final Product product;
  int size;
  _UpdateReviewPageState(this.product);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reviewByIdBloc.getReviewUser(product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false, // tránh overcross
      resizeToAvoidBottomInset: true,
      body: StreamBuilder<ReviewUpdateResponse>(
        stream: reviewByIdBloc.reviewUser,
        builder: (context, AsyncSnapshot<ReviewUpdateResponse> snapshot) {
          if (snapshot.hasData) {
            // if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            //   return _buildErrorWidget(snapshot.data.error);
            // }
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              child: Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 30),
                      child: UpdateReview(
                        product: product,
                        review: snapshot.data.review,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueGrey),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }
}
