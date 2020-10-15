import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/Get_Product_Bloc.dart';
import 'package:swd_project/Model/Product.dart';
import 'package:swd_project/Model/ProductResponse.dart';

class ListProduct extends StatefulWidget {
  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productBloc.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Top App",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        StreamBuilder<List<Product>>(
          stream: productBloc.subject,
          builder: (context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasData) {
              return _buildProductWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        )
      ],
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
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
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

  Widget _buildProductWidget(List<Product> data) {
    List<Product> products = data;
    return ListView.builder(
      scrollDirection:
          Axis.vertical, //Vertical viewport was given unbounded height
      shrinkWrap: true,
      itemCount: products == null ? 0 : products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(29, 10, 30, 0),
          child: Container(
            width: 200,
            height: 90,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  new BoxShadow(
                      color: Colors.black54,
                      offset: new Offset(1.0, 2.0),
                      blurRadius: 3.5),
                ]),
            child: ListTile(
              leading: Container(
                width: 60,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.3),
                        offset: Offset(0, 5),
                        blurRadius: 25)
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(products[index].iconUrl),
                        radius: 20,
                      ),
                    ),
                  ],
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.fromLTRB(1, 0, 0, 24),
                child: Text(
                  products[index].name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Row(children: <Widget>[
                Flexible(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    strutStyle: StrutStyle(fontSize: 12.0),
                    text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        text: '${products[index].overview}'),
                  ),
                ),
              ]),
              onTap: () {
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (context) => ChatScreen(
                //       name: data[index]['name'].toString(),
                //       UrlImage: data[index]['imgUrl'].toString(),
                //     ),
                //   ),
                // );
              },
            ),
          ),
        );
      },
    );
  }
}
