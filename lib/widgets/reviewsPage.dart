import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:hello/widgets/customColor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class reviewsPage extends StatefulWidget {
  reviewsPage({Key key}) : super(key: key);

  @override
  _reviewsPage createState() => _reviewsPage();
}

class _reviewsPage extends State<reviewsPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  final formKey = new GlobalKey<FormState>();
  int _rating;
  int _platform;
  List _platforms = ["Netflix", "Amazon Prime", "Disney+ Hotstar"];
  List _platform_id = ["NETFLIX", "APV", "HOTSTAR"];
  int _logo;

  @override
  void initState() {
    super.initState();
    this._rating = null;
    this._platform = null;
    this._logo = null;
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.7),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));
  }

  List _logos = ["DARK", "LIGHT"];
  final TextEditingController _reviewController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dynamic mv = ModalRoute.of(context).settings.arguments;
    _controller.forward();
    return Container(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: customColor.hexToColor(customColor.forestBlues),
          title: Text(
            "Write a Review",
            style: TextStyle(
                color: Colors.white, fontFamily: 'alfaSlabOne', fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
          // leading: null,
        ),
        backgroundColor: customColor.hexToColor(customColor.forestBlues),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(children: [
                  mv["bdpath"] != null
                      ? Container(
                          child: Center(
                            child: Stack(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: "assets/loader3.gif",
                                    image: "https://image.tmdb.org/t/p/w500/" +
                                        mv["bdpath"],
                                    fit: BoxFit.fitHeight,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Container(
                          child: Center(
                            child: Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: "assets/loader3.gif",
                                    image: "https://image.tmdb.org/t/p/w500/" +
                                        mv['imagedata']["file_path"]
                                            .substring(1),
                                    fit: BoxFit.fitWidth,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                  SlideTransition(
                    position: _offsetAnimation,
                    child: Container(
                      // color: customColor.hexToColor(customColor.forestBlues),
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.2),
                      padding: EdgeInsets.only(top: 100),
                      alignment: Alignment.topCenter,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: customColor
                              .hexToColor(customColor.waterfallEdited),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.elliptical(
                                  MediaQuery.of(context).size.width * 0.5, 100),
                              topRight: Radius.elliptical(
                                  MediaQuery.of(context).size.width * 0.5,
                                  100))),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        alignment: Alignment.center,
                        child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    mv["name"],
                                    style: TextStyle(
                                        color: customColor.hexToColor(
                                            customColor.forestBlues),
                                        fontFamily: 'alfaSlabOne',
                                        fontSize: 30),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 55),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          child: Icon(
                                        Icons.create,
                                        color: customColor.hexToColor(
                                            customColor.forestBlues),
                                      )),
                                      Spacer(),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: TextFormField(
                                          autofocus: false,
                                          maxLines: null,
                                          maxLength: null,
                                          controller: _reviewController,
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            hintText: "Review",
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "Please Enter the Review";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: Icon(
                                          Icons.stars,
                                          color: customColor.hexToColor(
                                              customColor.forestBlues),
                                        )),
                                        Spacer(),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: DropdownButtonFormField(
                                            onTap: () => FocusManager
                                                .instance.primaryFocus
                                                .unfocus(),
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            hint: Text("Choose Rating"),
                                            value: _rating,
                                            onChanged: (value) {
                                              formKey.currentState.validate();
                                              setState(() {
                                                _rating = value;
                                                // print("changed");
                                                // print(_rating);
                                              });
                                            },
                                            validator: (value) => value == null
                                                ? 'field required'
                                                : null,
                                            items: [
                                              0,
                                              0.5,
                                              1,
                                              1.5,
                                              2,
                                              2.5,
                                              3,
                                              3.5,
                                              4,
                                              4.5,
                                              5
                                            ]
                                                .map((e) => DropdownMenuItem(
                                                      child: Text(e.toString()),
                                                      value: (e * 2).toInt(),
                                                    ))
                                                .toList(),
                                          ),
                                        )
                                      ]),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: Icon(
                                          Icons.tv,
                                          color: customColor.hexToColor(
                                              customColor.forestBlues),
                                        )),
                                        Spacer(),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: DropdownButtonFormField(
                                            onTap: () => FocusManager
                                                .instance.primaryFocus
                                                .unfocus(),
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            hint: Text("Choose Platform"),
                                            value: _platform,
                                            onChanged: (value) {
                                              formKey.currentState.validate();
                                              setState(() {
                                                _platform = value;
                                                // print("changed");
                                              });
                                            },
                                            validator: (value) => value == null
                                                ? 'field required'
                                                : null,
                                            items: [0, 1, 2]
                                                .map((e) => DropdownMenuItem(
                                                      child: Text(_platforms[e]
                                                          .toString()),
                                                      value: e,
                                                    ))
                                                .toList(),
                                          ),
                                        )
                                      ]),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: Icon(
                                          Icons.brush,
                                          color: customColor.hexToColor(
                                              customColor.forestBlues),
                                        )),
                                        Spacer(),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: DropdownButtonFormField(
                                            onTap: () => FocusManager
                                                .instance.primaryFocus
                                                .unfocus(),
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            hint: Text(
                                                "Choose Logo Background Color"),
                                            value: _logo,
                                            validator: (value) => value == null
                                                ? 'field required'
                                                : null,
                                            onChanged: (value) {
                                              formKey.currentState.validate();
                                              setState(() {
                                                _logo = value;
                                                // print("changed");
                                              });
                                            },
                                            items: [0, 1]
                                                .map((e) => DropdownMenuItem(
                                                      child: Text(
                                                          _logos[e].toString()),
                                                      value: e,
                                                    ))
                                                .toList(),
                                          ),
                                        )
                                      ]),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 20, bottom: 300),
                                  width: 120,
                                  child: FlatButton(
                                    color: Theme.of(context).primaryColor,
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    onPressed: () {
                                      if (formKey.currentState.validate()) {
                                        pushData(
                                                mv,
                                                _reviewController.text,
                                                (_rating / 2).toString(),
                                                _platform_id[_platform],
                                                _logos[_logo])
                                            .then((value) {
                                          if (value != null) {
                                            Fluttertoast.showToast(
                                                msg: "Review Uploaded",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.TOP,
                                                backgroundColor: customColor
                                                    .hexToColor(customColor
                                                        .forestBlues),
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            _launchURL(
                                                    'https://www.reviewsbyvatsa.wtf/',
                                                    mv["type"],
                                                    mv["id"].toString())
                                                .then((value) {
                                              Navigator.popUntil(context,
                                                  ModalRoute.withName('/'));
                                            });
                                          } else if (value == "error") {
                                            Fluttertoast.showToast(
                                                msg: "Network Error",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: customColor
                                                    .hexToColor(customColor
                                                        .forestBlues),
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Server Not Reachable",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: customColor
                                                    .hexToColor(customColor
                                                        .forestBlues),
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        });
                                      }
                                      // .then((value) => Navigator.popUntil(
                                      //     context, ModalRoute.withName('/')));
                                    },
                                    child: Text(
                                      "SUBMIT",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<String> pushData(dynamic mv, String creview, String crating,
    String cplatform, String clogo) async {
  String movie_id = mv['id'].toString();
  String imgurl = mv['imagedata']["file_path"].substring(1);
  String name = mv["name"];
  String review = creview;
  String rating = crating;
  String platform = cplatform;
  String dark = clogo;
  String bdpath = mv["bdpath"];

  List genresL = mv["genres"].map((val) {
    return val["name"];
  }).toList();
  var string = genresL.toString();
  String genres = (string.substring(1, string.length - 1));
  http.Response response;
  try {
    response = await http.post(
      'https://www.reviewsbyvatsa.wtf/save/' + mv["type"].toString(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "movie_id": movie_id,
        "imgurl": imgurl,
        "name": name,
        "review": review,
        "rating": rating,
        "platform": platform,
        "dark": dark,
        "bdpath": bdpath,
        "genres": genres
      }),
    );
  } on SocketException catch (e) {
    print(e.toString());
    return null;
  } catch (e) {
    print(e);
    return null;
  }
  if (response.statusCode == 200) {
    // print("doneeeee");
    // _launchURL('/', mv["type"], movie_id);
    return response.body;
  } else {
    // print(response.body);
    return "error";
  }
}

_launchURL(url, type, id) async {
  String svg = type == 0 ? 'svg/' : 'svg_series/';
  // print(url + svg + id);
  // const url = 'https://flutter.io';
  if (await canLaunch(url + svg + id)) {
    await launch(
      url + svg + id,
    );
  } else {
    throw 'Could not launch $url';
  }
}
