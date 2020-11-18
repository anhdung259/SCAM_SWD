import 'package:expandable_group/expandable_group_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jiffy/jiffy.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:swd_project/Bloc/User/Update_Profile_Bloc.dart';
import 'package:swd_project/Model/Industry/industry.dart';
import 'package:swd_project/Model/User/IndustryExpert.dart';
import 'package:swd_project/Bloc/User/User_Bloc.dart';
import 'package:swd_project/Model/User/User.dart';
import 'package:swd_project/Model/User/UserResponse.dart';
import 'package:swd_project/Model/User/UserReview.dart';
import 'package:swd_project/Widget/load_and_error-process.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfile createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
    userBloc.getUser();
    userBloc.getIndustryOfUser();
    userBloc.getAllIndustry();
  }

  bool checkUpdate = true;
  bool isSelected = false;
  User detaiUser;
  List<IndustryExpert> _listIndustryExpert = [];
  List<IndustryExpert> _tmp = [];

  TextEditingController _name;

  TextEditingController _mail;

  TextEditingController _facebook;

  TextEditingController _phone;

  TextEditingController _createDate;

  TextEditingController _provider;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserResponse>(
        stream: userBloc.userProfile,
        builder: (context, AsyncSnapshot<UserResponse> snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data.user;
            _name =
            new TextEditingController(text: checkNull(user.name).trim());
            _mail =
            new TextEditingController(text: checkNull(user.email).trim());
            _facebook = new TextEditingController(
                text: checkNull(user.facebook).trim());
            _phone =
            new TextEditingController(text: checkNull(user.phone).trim());
            _provider = new TextEditingController(
                text: checkNull(user.provider).trim());
            return Container(
              padding: EdgeInsets.only(left: 16, top: 0, right: 16),
              child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
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
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
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
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    color: Colors.black87,
                                  ),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    onTap: () {
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
                      buildTextField("Ngày tạo tài khoản",
                          Jiffy(user.joinDate).yMMMd, _createDate),
                      buildTextField(
                          "Đăng nhập bằng", user.provider, _provider),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lĩnh vực của tôi",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              icon: Icon(checkUpdate
                                  ? Icons.remove_red_eye
                                  : Icons.edit),
                              onPressed: () {
                                checkUpdate
                                    ? showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Lĩnh vực của bạn"),
                                        content: StreamBuilder<
                                            List<IndustryExpert>>(
                                          stream: userBloc.userIndustry,
                                          builder: (context,
                                              AsyncSnapshot<
                                                  List<IndustryExpert>>
                                              snapshot) {
                                            if (snapshot.hasData) {
                                              List<IndustryExpert>
                                              _lisIndustry =
                                                  snapshot.data;
                                              return Container(
                                                  height: 500,
                                                  width: 400,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                    _lisIndustry.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ExpandableGroup(
                                                        header: Text(
                                                          _lisIndustry[
                                                          index]
                                                              .industry
                                                              .name,
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize: 15),
                                                        ),
                                                        items: [
                                                          ListTile(
                                                            title: Row(
                                                              children: [
                                                                Text(
                                                                    "Độ thích: ",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.bold)),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                      45),
                                                                  child:
                                                                  RatingBarIndicator(
                                                                    rating:
                                                                    _lisIndustry[index].interestLevel /
                                                                        1,
                                                                    itemCount:
                                                                    5,
                                                                    itemSize:
                                                                    20,
                                                                    direction:
                                                                    Axis.horizontal,
                                                                    itemBuilder:
                                                                        (context,
                                                                        index) {
                                                                      return Icon(
                                                                        Icons.star,
                                                                        color:
                                                                        Colors.yellow,
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            subtitle: Row(
                                                              children: [
                                                                Text(
                                                                  "Độ chuyên gia: ",
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .bold,
                                                                      color: Colors
                                                                          .black87,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                      10),
                                                                  child:
                                                                  RatingBarIndicator(
                                                                    rating:
                                                                    _lisIndustry[index].expertLevel /
                                                                        1,
                                                                    itemCount:
                                                                    5,
                                                                    itemSize:
                                                                    20,
                                                                    direction:
                                                                    Axis.horizontal,
                                                                    itemBuilder:
                                                                        (context,
                                                                        index) {
                                                                      return Icon(
                                                                        Icons.star,
                                                                        color:
                                                                        Colors.yellow,
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      );
                                                    },
                                                  ));
                                            } else if (snapshot.hasError) {
                                              return BuildError(
                                                error: snapshot.error,
                                              );
                                            } else {
                                              return BuildLoading();
                                            }
                                          },
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context, false);
                                              },
                                              child: Text("Quay lại"
                                                  .toUpperCase())),
                                        ],
                                      );
                                    })
                                    : showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StreamBuilder<List<IndustryClass>>(
                                        stream: userBloc.allIndustry,
                                        builder: (context, AsyncSnapshot<List<IndustryClass>> snapshot) {
                                          if (snapshot.hasData) {
                                            List<IndustryClass> _lisIndustry = snapshot.data;

                                            return  MultiSelectDialog(
                                              items: _lisIndustry.map((industry) => MultiSelectItem<IndustryClass>(industry, industry.name)).toList(),
                                              onConfirm: (values) {
                                                if(values.isNotEmpty){
                                                  for(int i= 0 ; i < values.length; i++){
                                                    print("_______xxx${values[i].id}");
                                                    print("_______xxx${user.id}");
                                                    IndustryExpert temp = new IndustryExpert(
                                                      id: values[i].id,
                                                      userId: user.id,
                                                      status: true,
                                                    );
                                                    _tmp.add(temp);
                                                    print("_______lol${_tmp.length}");
                                                  }
                                                  return showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {

                                                        return AlertDialog(
                                                          title: Text("Chọn độ thích và chuyên gia"),
                                                          content: Container(
                                                            width: 300,
                                                            height: 500,
                                                            child: ListView.builder(
                                                              shrinkWrap: true,
                                                              itemCount: values.length,
                                                              itemBuilder: (context, index){
                                                                return Column(
                                                                  children: [
                                                                    Text(values[index].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),),
                                                                    SizedBox(
                                                                      height: 10,
                                                                    ),
                                                                    Text("độ thích"),
                                                                    RatingBar.builder(
                                                                      itemBuilder: (context, _) => Icon(
                                                                        Icons.star,
                                                                        color: Colors.amber,
                                                                        size: 10,
                                                                      ),
                                                                      onRatingUpdate: (rating){
                                                                        _tmp[index].interestLevel = rating.round();
                                                                        print("$rating /${values[index].id} / ${_tmp[index].interestLevel}");

                                                                      },

                                                                      initialRating: 0,
                                                                      minRating: 1,
                                                                      direction: Axis.horizontal,
                                                                      allowHalfRating: true,
                                                                      itemCount: 5,
                                                                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                                    ),
                                                                    Text("độ chuyên gia"),
                                                                    RatingBar.builder(
                                                                      itemBuilder: (context, _) => Icon(
                                                                        Icons.star,
                                                                        color: Colors.amber,
                                                                        size: 10,
                                                                      ),
                                                                      onRatingUpdate: (rating){
                                                                        _tmp[index].interestLevel = rating.round();
                                                                        print("$rating /${values[index].id} / ${_tmp[index].interestLevel}");
                                                                      },
                                                                      initialRating: 0,
                                                                      minRating: 1,
                                                                      direction: Axis.horizontal,
                                                                      allowHalfRating: true,
                                                                      itemCount: 5,
                                                                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context, false);
                                                                },
                                                                child: Text("Hủy"
                                                                    .toUpperCase())),
                                                            TextButton(
                                                                onPressed: () async{

                                                                  setState(() {
                                                                    _listIndustryExpert = _tmp;
                                                                  });
                                                                  int status = await updateUserBloc.updateUserIndustry(_tmp);
                                                                  if(status == 200){
                                                                    print("___done");
                                                                  }else{
                                                                    print("___fail");
                                                                  }
                                                                },
                                                                child: Text("Lưu lại"
                                                                    .toUpperCase())),
                                                          ],
                                                        );
                                                      });
                                                }else{
                                                  return null;
                                                }
                                              },
                                              cancelText: Text("Hủy"),
                                              confirmText: Text("Tiếp tục"),

                                            );
                                            // children: [
                                            //   Container(
                                            //       height: 200,
                                            //       width: 500,
                                            //       child: MultiSelectItem(
                                            //         items: _lisIndustry.map((industry) => MultiSelectItem<IndustryClass>(industry, industry.name)).toList(),
                                            //         icon: Icon(Icons.check),
                                            //         onTap: (values) {
                                            //           print(values.first.name);
                                            //           setState(() {
                                            //             _listSelectIndustry.add(Text("a"));
                                            //           });
                                            //         },
                                            //       ),



                                          } else if (snapshot.hasError) {
                                            return BuildError(
                                              error: snapshot.error,
                                            );
                                          } else {
                                            return BuildLoading();
                                          }
                                        },
                                      );
                                    });
                              })
                        ],
                      ),
                      checkUpdate
                          ? Container(
                        width: 40,
                        child: RaisedButton(
                          onPressed: () {},
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Đăng xuất",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.white),
                          ),
                        ),
                      )
                          : Row(
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
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.black87),
                            ),
                          ),
                          RaisedButton(
                            onPressed: ()  async{
                              int status = await updateUserBloc.updateUserProfile(new UserDetail(
                                  id: user.id,
                                  avatarUrl: user.avatarUrl,
                                  status: user.status,
                                  email: _mail.text.trim(),
                                  phone: _phone.text.trim(),
                                  facebook: _facebook.text.trim(),
                                  joinDate: user.joinDate,
                                  provider: _provider.text.trim(),
                                  role: user.role,
                                  name: _name.text.trim(),
                                  bio: user.bio
                              ));
                              if(status == 200){
                                print("done");
                                setState(() {
                                  userBloc.getUser();
                                  checkUpdate = true;
                                });
                              }else{
                                print("fail");
                              }
                            },
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "Lưu thay đổi",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.black87),
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
