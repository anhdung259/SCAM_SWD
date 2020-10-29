import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swd_project/Bloc/TaskMenu/CheckSubCate.dart';
import 'package:swd_project/Model/Category.dart';

class GenerateMenu extends StatefulWidget {
  final List<Category> categories;

  GenerateMenu({Key key, @required this.categories}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GenerateMenu(categories);
  }
}

class _GenerateMenu extends State<GenerateMenu>
    with SingleTickerProviderStateMixin {
  final List<Category> categories;

  _GenerateMenu(this.categories);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Container(
        child: InkWell(
          splashColor: Color.fromARGB(255, 18, 32, 50),
          onTap: () {},
          child: Column(
            children: <Widget>[
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      if (categories[index].categoryId == null)
                        ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      categories[index].name,
                                      style: TextStyle(
                                        color: Colors.blueGrey[800],
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          children: [
                            if(!checkSubCate(categories, categories[index].id).contains("false"))
                            ExpansionTile(
                              title: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 40),
                                        child: Text(
                                          checkSubCate(categories, categories[index].id),
                                          style: TextStyle(
                                            color: Colors.blueGrey[800],
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}