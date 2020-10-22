import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/Get_Product_Bloc.dart';
import 'package:swd_project/Components/ProductByCate.dart';
import 'package:swd_project/Model/Category.dart';

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
      height: 800,
      child: DefaultTabController(
          length: categories.length,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Các loại phần mềm phổ biến".toUpperCase(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              backgroundColor: Colors.white,
              bottom: TabBar(
                onTap: (num) {
                  print(num);
                },
                controller: _tabController,
                indicatorColor: Colors.deepOrange,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                unselectedLabelColor: Colors.black,
                labelColor: Colors.black,
                isScrollable: true,
                tabs: categories.map((Category category) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 10.0, top: 5.0),
                    child: Text(category.name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54)),
                  );
                }).toList(),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 50),
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
