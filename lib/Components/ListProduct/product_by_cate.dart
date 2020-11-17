import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:swd_project/Bloc/get_Product_Bloc.dart';
import 'package:swd_project/Model/Product/Product.dart';
import 'package:swd_project/Pages/detail_product.dart';
import 'package:swd_project/Widget/load_and_error-process.dart';
import 'search_bar.dart';

class ProductByCate extends StatefulWidget {
  final int categoryId;
  final String nameCategory;
  final int currentPage;
  final int pageSize;
  const ProductByCate(
      {Key key,
      this.categoryId,
      this.nameCategory,
      this.pageSize,
      this.currentPage})
      : super(key: key);

  @override
  _ProductByCateState createState() =>
      _ProductByCateState(categoryId, nameCategory, pageSize, currentPage);
}

class _ProductByCateState extends State<ProductByCate>
    with TickerProviderStateMixin {
  final int categoryId;
  int pageSize;
  int currentPage;
  final String nameCategory;
  _ProductByCateState(
      this.categoryId, this.nameCategory, this.pageSize, this.currentPage);
  RefreshController _controller1 = RefreshController();
  @override
  void initState() {
    super.initState();
    _getMoreData();
    _controller1 = RefreshController();
  }

  void _onRefresh() {
    Future.delayed(const Duration(milliseconds: 2009)).then((val) {
      _controller1.refreshCompleted();
//                refresher.sendStatus(RefreshStatus.completed);
    });
  }

  void _onLoading() {
    Future.delayed(const Duration(milliseconds: 2009)).then((val) {
      _getMoreData();
    });
  }

  void _getMoreData() async {
    productBloc.getProductByCategory(categoryId, currentPage, pageSize);
    if (mounted) {
      _controller1.loadComplete();
      currentPage++;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
    productBloc.dainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 32, 50),
        title: Text(nameCategory),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                EvaIcons.searchOutline,
                color: Colors.white,
              ),
              onPressed: () {
                showSearch(context: (context), delegate: searchBar);
              })
        ],
      ),
      body: StreamBuilder<List<Product>>(
        stream: productBloc.proCate,
        builder: (context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {
            return _buildProductWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return BuildError(
              error: snapshot.error,
            );
          } else {
            return BuildLoading();
          }
        },
      ),
    );
  }

  Widget _buildProductWidget(List<Product> data) {
    List<Product> products = data;
    print(products.length);
    if (products.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "list app empty",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Padding(
        padding: const EdgeInsets.all(13.0),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: _controller1,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: products.length,
            physics: ScrollPhysics(),
            // ngao ngao ko scroll này
            itemBuilder: (BuildContext context, int index) {
              return new Card(
                child: InkResponse(
                  onTap: () async {
                    await productBloc.getProductDetail(products[index].id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          product: products[index],
                        ),
                      ),
                    );
                  },
                  child: new GridTile(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            new BoxShadow(
                                color: Colors.white.withOpacity(0.2),
                                offset: new Offset(0.1, 2.0),
                                blurRadius: 3.8),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              width: 97,
                              height: 88,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: NetworkImage(products[index].iconUrl),
                                fit: BoxFit.fill,
                              )),
                              // backgroundImage:
                              //     NetworkImage(products[index].iconUrl),
                              // radius: 56,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              products[index].name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // child: new Text(products[index].), //just for testing, will fill with image later
                  ),
                ),
              );
            },
          ),
        ),
      );
  }
}
