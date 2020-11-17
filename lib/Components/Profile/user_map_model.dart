import 'package:expandable_group/expandable_group_widget.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:localstorage/localstorage.dart';
import 'package:swd_project/Components/TaskMenu/listtle_list.dart';
import 'package:swd_project/Model/User/UserReview.dart';
import 'package:swd_project/Widget/load_and_error-process.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfile createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  final LocalStorage storage = LocalStorage('user');

  @override
  void initState() {
    super.initState();
  }

  bool checkUpdate = true;
  User detaiUser;
  TextEditingController _name ;
  TextEditingController _mail ;
  TextEditingController _facebook ;
  TextEditingController _phone ;
  TextEditingController _createDate ;
  TextEditingController _provider ;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: storage.ready,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var user = User.fromJsonProfile(storage.getItem('user'));
            _name = new TextEditingController(text: checkNull(user.name).trim());
            _mail = new TextEditingController(text: checkNull(user.email).trim());
            _facebook = new TextEditingController(text: checkNull(user.facebook).trim());
            _phone = new TextEditingController(text: checkNull(user.phone).trim());
            _provider = new TextEditingController(text: checkNull(user.provider).trim());
            return Container(
              padding: EdgeInsets.only(left: 16, top: 0, right: 16),
              child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      // Center(
                      //   child: Text(
                      //     "Trang cá nhân",
                      //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                      //   ),
                      // ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 4,
                                      color:
                                      Theme.of(context).scaffoldBackgroundColor),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(0, 10))
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        user.avatarUrl,
                                      ))),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 4,
                                      color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                    ),
                                    color: Colors.black87,
                                  ),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    onTap: (){
                                      setState(() {
                                        checkUpdate = false;
                                      });
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      buildTextField("Tên", user.name, _name),
                      buildTextField("Mail", user.email, _mail),
                      buildTextField("Facebook", user.facebook, _facebook),
                      buildTextField("Số điện thoại", user.phone, _phone),
                      buildTextField("Ngày tạo tài khoản", Jiffy(user.joinDate).yMMMd, _createDate),
                      buildTextField("Đăng nhập bằng", user.provider, _provider),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Lĩnh vực của tôi", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                          IconButton(icon: Icon(
                              checkUpdate ? Icons.remove_red_eye : Icons.edit),
                              onPressed: (){
                                checkUpdate ?

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Lĩnh vực của tôi"),
                                    content: Container(
                                      height: 300,
                                      width: 200,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: 10,
                                        itemBuilder: (context, index){
                                          return ExpandableGroup(
                                            header: Text("Industry name"),
                                            items: [
                                              ListTile(
                                                title: Text("In L.V"),
                                                subtitle: Text("Ex L.V"),
                                              )
                                            ],
                                          );
                                        },
                                      )
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: Text("Quay lại".toUpperCase())),
                                    ],
                                  );
                                }) :

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Chỉnh sữa lĩnh vực"),
                                        content: Container(
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, false);
                                              },
                                              child: Text("Cancel".toUpperCase())),
                                          TextButton(
                                              onPressed: () async {
                                              },
                                              child: Text("Update".toUpperCase()))
                                        ],
                                      );
                                    });
                              }
                          )
                        ],
                      ),
                      checkUpdate ? Container(
                        width: 40,
                        child: RaisedButton(
                          onPressed: () {},
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Đăng xuất",
                            style: TextStyle(
                                fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                          ),
                        ),
                      ) :
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RaisedButton(
                            onPressed: () {
                              setState(() {
                                checkUpdate = true;
                              });
                            },
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "Hủy",
                              style: TextStyle(
                                  fontSize: 14, letterSpacing: 2.2, color: Colors.black87),
                            ),
                          ),RaisedButton(
                            onPressed: () {},
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "Lưu thay đổi",
                              style: TextStyle(
                                  fontSize: 14, letterSpacing: 2.2, color: Colors.black87),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            );
          } else if (snapshot.hasError) {
            return BuildError(
              error: snapshot.error,
            );
          } else {
            return BuildLoading();
          }
        });
  }

  Widget buildTextField(
      String labelText, String placeholder, TextEditingController tmp) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        controller: tmp,
        readOnly: checkUpdate,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 1),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 15,
              color: Colors.black,
            )),
      ),
    );
  }
}
String checkNull(String temp) {
  if (temp == null) {
    return "";
  }
  return temp;
}
