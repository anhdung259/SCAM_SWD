import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:swd_project/Bloc/get_industry_bloc.dart';
import 'package:swd_project/Model/Industry/industry.dart';
import 'package:swd_project/Model/Product/Product.dart';
import 'package:swd_project/Model/ReviewAnswer/ReviewList.dart';
import 'package:swd_project/Pages/detail_product.dart';

class Filter extends StatefulWidget {
  final Product product;
  final List<Review> reviews;

  const Filter({Key key, this.product, this.reviews}) : super(key: key);

  @override
  _FilterState createState() => _FilterState(product, reviews);
}

class _FilterState extends State<Filter> {
  final Product product;
  final List<Review> reviews;
  String industryId;
  Map<String, bool> values = {
    '5': false,
    '4': false,
    '3': false,
    '2': false,
    '1': false,
  };

  List<IndustryClass> listIndustryFilter = [];

  _FilterState(this.product, this.reviews);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    industryBloc.getListIndustryReview(product.id).then((value) => setState(() {
          listIndustryFilter = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300,
            child: ListView(
              children: values.keys.map((String key) {
                return new CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Row(
                    children: [
                      Text(key),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 230,
                        animation: true,
                        lineHeight: 21.0,
                        animationDuration: 1000,
                        percent: getPercent(key) ?? 0,
                        center: Text((getPercent(key) * 100).toString() + "%",
                            style: TextStyle(color: Colors.white)),
                        animateFromLastPercent: true,
                        progressColor: Colors.orange[400],
                        // maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(getNumPeople(key).toString()),
                    ],
                  ),
                  value: values[key],
                  onChanged: (bool value) {
                    setState(() {
                      values[key] = value;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          DropdownSearch<IndustryClass>(
            label: "Chọn lĩnh vực",
            mode: Mode.MENU,
            items: listIndustryFilter,
            itemAsString: (IndustryClass u) => u.name.toString(),
            onChanged: (IndustryClass data) {
              setState(() {
                industryId = "industryId=" + data.id.toString() + "&";
                print(industryId);
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              width: 200,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                color: Colors.green,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(
                        builder: (context) => new DetailPage(
                            page: 1,
                            product: product,
                            queryFilter: getQueryFilter() ??
                                "rates=5&rates=4&rates=3&rates=2&rates=1&" +
                                    "${industryId ?? ""}"),
                      ),
                      (Route<dynamic> route) => route.isFirst); //phải vạy chứ
                },
                child: Text(
                  'Áp dụng',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  getQueryFilter() {
    List<String> listCheck = [];
    String qrl = "";
    values.forEach((key, value) {
      if (value == true) {
        listCheck.add("rates=" + key + "&");
      }
    });
    if (listCheck.isEmpty) {
      return null;
    } else {
      qrl = listCheck.reduce((value, element) => value + element) +
          "${industryId ?? ""}";
      print(qrl);
      return qrl;
    }
  }

  getPercent(String starPercent) {
    double rate = double.parse(starPercent);
    return reviews
            .where((r) => r.rate.roundToDouble() == rate)
            .toList()
            .length /
        reviews.length;
  }

  getNumPeople(String starPercent) {
    double rate = double.parse(starPercent);
    return reviews.where((r) => r.rate.roundToDouble() == rate).toList().length;
  }
}
