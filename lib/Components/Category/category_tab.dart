import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/get_Product_Bloc.dart';
import 'package:swd_project/Components/ListProduct/product_by_cate.dart';
import 'package:swd_project/Model/Category/Category.dart';

class CategoryTab extends StatefulWidget {
  final List<Category> categories;
  CategoryTab({Key key, @required this.categories}) : super(key: key);
  @override
  _CategoryTabState createState() => _CategoryTabState(categories);
}

class _CategoryTabState extends State<CategoryTab>
    with SingleTickerProviderStateMixin {
  final List<Category> categories;
  TabController _tabController;
  _CategoryTabState(this.categories);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    if (_tabController.indexIsChanging) {
      productBloc.dainStream();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: DefaultTabController(
          length: categories.length,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                backgroundColor: Colors.white,
                bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.deepOrange,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3.0,
                  unselectedLabelColor: Colors.blue,
                  labelColor: Colors.blue,
                  isScrollable: true,
                  tabs: categories.map((Category category) {
                    return Container(
                      padding: EdgeInsets.only(bottom: 10.0, top: 5.0),
                      child: Text(category.name.toUpperCase(),
                          style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                              color: Colors.black87)),
                    );
                  }).toList(),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 35),
              child: TabBarView(
                  controller: _tabController,
                  children: categories.map((Category cate) {
                    return ProductByCate(categoryId: cate.id);
                  }).toList()),
            ),
          )),
    );
  }
}
