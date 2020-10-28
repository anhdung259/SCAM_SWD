import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/Get_Product_Bloc.dart';
import 'package:swd_project/Model/Product.dart';
import 'package:swd_project/Model/ProductResponse.dart';
import 'package:swd_project/Pages/DetailProduct.dart';

import 'SearchBar.dart';

class ProductByCate extends StatefulWidget {
  final int categoryId;
  final String nameCategory;

  const ProductByCate({Key key, this.categoryId, this.nameCategory})
      : super(key: key);

  @override
  _ProductByCateState createState() =>
      _ProductByCateState(categoryId, nameCategory);
}

class _ProductByCateState extends State<ProductByCate> {
  final int categoryId;
  final String nameCategory;
  _ProductByCateState(this.categoryId, this.nameCategory);

  @override
  void initState() {
    super.initState();
    productBloc.getProductByCategory(categoryId);
  }

  @override
  void dispose() {
    super.dispose();
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
      drawer: Drawer(),
      body: StreamBuilder<ProductResponse>(
        stream: productBloc.proCate,
        builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _buildErrorWidget(snapshot.data.error);
            }
            return _buildProductWidget(snapshot.data);
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
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
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
        Text("Error occurred: $error"),
      ],
    ));
  }

  Widget _buildProductWidget(ProductResponse data) {
    List<Product> products = data.products;

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
        padding: const EdgeInsets.all(6.0),
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
                onTap: () {
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
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          new BoxShadow(
                              color: Colors.black54.withOpacity(0.7),
                              offset: new Offset(0.2, 3.0),
                              blurRadius: 3.7),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          child: Container(
                            width: 97,
                            height: 87,
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
                        Text(
                          products[index].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
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
      );
  }
}
