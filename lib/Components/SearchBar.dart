import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/Get_Product_Bloc.dart';
import 'package:swd_project/Model/Product.dart';
import 'package:swd_project/Model/ProductResponse.dart';
import 'package:swd_project/Pages/DetailProduct.dart';

class ProductSearch extends SearchDelegate<String> {
  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
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

  @override
  Widget buildSuggestions(BuildContext context) {
    productBloc..getProduct();
    return StreamBuilder<ProductResponse>(
        stream: productBloc.subject,
        builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
          if (snapshot.hasData) {
            return listWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        });
  }

  Widget listWidget(ProductResponse data) {
    final List<Product> suggestionList = query.isEmpty
        ? data.products.take(10).toList()
        : data.products
            .where((q) => q.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailPage(product: suggestionList[index]),
                ),
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(suggestionList[index].iconUrl),
                radius: 20,
              ),
              title: Text(suggestionList[index].name),
            ),
          );
        });
  }
}

final searchBar = ProductSearch();
