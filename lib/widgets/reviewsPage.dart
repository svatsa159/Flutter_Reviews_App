import 'dart:convert';
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

class _reviewsPage extends State<reviewsPage> {
  final formKey = new GlobalKey<FormState>();
  int _rating;
  int _platform;
  List _platforms = ["Netflix", "Amazon Prime", "Disney+ Hotstar"];
  List _platform_id = ["NETFLIX", "APV", "HOTSTAR"];
  int _logo;

  @override
  @override
  void initState() {
    super.initState();
    this._rating = null;
    this._platform = null;
    this._logo = null;
  }

  List _logos = ["DARK", "LIGHT"];
  final TextEditingController _reviewController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dynamic mv = ModalRoute.of(context).settings.arguments;

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
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Stack(
                      children: [
                        Container(
                          decoration: mv["bdpath"] != null
                              ? BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        "https://image.tmdb.org/t/p/w500/" +
                                            mv["bdpath"],
                                      )))
                              : BoxDecoration(color: Colors.transparent),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.2),
                    child: Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        color: customColor.hexToColor(customColor.forestBlues),
                        padding: EdgeInsets.only(top: 100),
                        alignment: Alignment.topCenter,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color:
                                customColor.hexToColor(customColor.forestBlues),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.elliptical(
                                    MediaQuery.of(context).size.width * 0.5,
                                    100),
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
                                    // padding: EdgeInsets.only(top: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(top: 25),
                                            child: Icon(Icons.create)),
                                        Spacer(),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: TextFormField(
                                            autofocus: false,
                                            maxLines: null,
                                            maxLength: null,
                                            controller: _reviewController,
                                            decoration: InputDecoration(
                                              labelText: "Review",
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
                                              margin: EdgeInsets.only(top: 15),
                                              child: Icon(Icons.stars)),
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
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  contentPadding:
                                                      EdgeInsets.all(5)),
                                              hint: Text("Choose Rating"),
                                              value: _rating,
                                              onChanged: (value) {
                                                formKey.currentState.validate();
                                                setState(() {
                                                  _rating = value;
                                                  print("changed");
                                                  print(_rating);
                                                });
                                              },
                                              validator: (value) =>
                                                  value == null
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
                                                        child:
                                                            Text(e.toString()),
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
                                              margin: EdgeInsets.only(top: 15),
                                              child: Icon(Icons.stars)),
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
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  contentPadding:
                                                      EdgeInsets.all(5)),
                                              hint: Text("Choose Platform"),
                                              value: _platform,
                                              onChanged: (value) {
                                                formKey.currentState.validate();
                                                setState(() {
                                                  _platform = value;
                                                  print("changed");
                                                });
                                              },
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              items: [0, 1, 2]
                                                  .map((e) => DropdownMenuItem(
                                                        child: Text(
                                                            _platforms[e]
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
                                              margin: EdgeInsets.only(top: 15),
                                              child: Icon(Icons.stars)),
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
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  contentPadding:
                                                      EdgeInsets.all(5)),
                                              hint: Text("Choose Platform"),
                                              value: _logo,
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              onChanged: (value) {
                                                formKey.currentState.validate();
                                                setState(() {
                                                  _logo = value;
                                                  print("changed");
                                                });
                                              },
                                              items: [0, 1]
                                                  .map((e) => DropdownMenuItem(
                                                        child: Text(_logos[e]
                                                            .toString()),
                                                        value: e,
                                                      ))
                                                  .toList(),
                                            ),
                                          )
                                        ]),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin:
                                        EdgeInsets.only(top: 20, bottom: 300),
                                    width: 120,
                                    child: RaisedButton(
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () {
                                        if (formKey.currentState.validate()) {
                                          pushData(
                                                  mv,
                                                  _reviewController.text,
                                                  (_rating / 2).toString(),
                                                  _platform_id[_platform],
                                                  _logos[_logo])
                                              .then((value) {
                                            Fluttertoast.showToast(
                                                msg: "Review Uploaded",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.TOP,
                                                backgroundColor:
                                                    Colors.red[400],
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            _launchURL(
                                                    'http://192.168.43.50:5000/',
                                                    mv["type"],
                                                    mv["id"].toString())
                                                .then((value) {
                                              // Navigator.popUntil(
                                              //     context, ModalRoute.withName('/'));
                                            });
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
  final http.Response response = await http.post(
    'http://192.168.43.50:5000/save/' + mv["type"].toString(),
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
  if (response.statusCode == 200) {
    print("doneeeee");
    // _launchURL('/', mv["type"], movie_id);
    return response.body;
  } else {
    print(response.body);
    throw Exception('Failed to load album');
  }
}

_launchURL(url, type, id) async {
  String svg = type == 0 ? 'svg/' : 'svg_series/';
  print(url + svg + id);
  // const url = 'https://flutter.io';
  if (await canLaunch(url + svg + id)) {
    await launch(
      url + svg + id,
    );
  } else {
    throw 'Could not launch $url';
  }
}
