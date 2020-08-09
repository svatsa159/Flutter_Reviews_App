import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello/widgets/customColor.dart';
import 'package:hello/models/Movie.dart';
import 'package:hello/widgets/myGrid.dart';
import 'package:hello/widgets/customColor.dart';

class newPage extends StatefulWidget {
  newPage({Key key}) : super(key: key);

  @override
  _newPageState createState() => _newPageState();
}

class _newPageState extends State<newPage> {
  List<Movie> ll = new List();
  @override
  Widget build(BuildContext context) {
    final dynamic data = ModalRoute.of(context).settings.arguments;

    var f = json.decode(data['x']);
    for (int i = 0; i < f.length; i++) {
      var movie = Movie.fromJson(f[i.toString()]);
      print(movie);
      ll.add(movie);
    }

    return Scaffold(
      backgroundColor: customColor.hexToColor(customColor.waterfallEdited),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: customColor.hexToColor(customColor.waterfallEdited),
        iconTheme: IconThemeData(
            color: customColor.hexToColor(customColor.forestBlues)),
        title: Text(
          "Search Results",
          style: TextStyle(
              color: customColor.hexToColor(customColor.forestBlues),
              fontFamily: 'alfaSlabOne',
              fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15, left: 5),
                  child: Text(
                    "Search Results for \"" + data['text'] + "\"",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'WorkSansRegular',
                        letterSpacing: -0.4),
                  ),
                ),
              ),
              myGrid(ll, data["val"])
            ],
          ),
        ),
      ),
    );
  }
}
