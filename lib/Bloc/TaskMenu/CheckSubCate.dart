import 'package:swd_project/Model/Category/Category.dart';

String checkSubCate(List<Category> category, int id) {
  String result = "false";
  for (int i = 0; i < category.length; i++) {
    if (category[i].categoryId != null) {
      if (category[i].categoryId == id) {
        result = category[i].name;
      }
    }
  }
  return result;
}

int checkSubCateID(List<Category> category, int id) {
  int result = -1;
  for (int i = 0; i < category.length; i++) {
    if (category[i].categoryId != null) {
      if (category[i].categoryId == id) {
        result = category[i].id;
      }
    }
  }
  return result;
}
