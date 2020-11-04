import 'package:flutter/material.dart';
import 'package:swd_project/Components/Category/category_data.dart';
import 'package:swd_project/Widget/SlideShow.dart';

class homeContent extends StatefulWidget {
  @override
  _homeContentState createState() => _homeContentState();
}

class _homeContentState extends State<homeContent> {
  final _controller = ScrollController();
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
        children: [SlideShow(), CategoryListIncludeProduct()],
      ),
    );
  }
}
