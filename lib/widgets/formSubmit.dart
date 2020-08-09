import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello/models/Movie.dart';
import 'package:hello/widgets/customColor.dart';
import 'package:http/http.dart' as http;

class formSubmit extends StatefulWidget {
  formSubmit({Key key}) : super(key: key);

  @override
  _formSubmitState createState() => _formSubmitState();
}

class _formSubmitState extends State<formSubmit> {
  final _form_key = GlobalKey<FormState>();
  int _x = 1;
  bool _isLoading = false;
  final TextEditingController _myController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form_key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextFormField(
              controller: _myController,
              onChanged: (value) {
                setState(() {});
              },
              textAlign: TextAlign.left,
              decoration: new InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.circular(10)),
                //             customColor.hexToColor(customColor.waterfallEdited))),
                hintText: "Search for Movies/Series",
                suffixIcon: _myController.text.length > 0
                    ? IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color:
                              customColor.hexToColor(customColor.forestBlues),
                        ),
                        onPressed: () {
                          _myController.clear();
                        },
                        // onPressed: () {
                        //   _myController.clear();
                        // },
                      )
                    : null,
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter Text';
                }
                return null;
              },
            ),
          ),
          Container(
            // alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width * 0.7,
            margin: EdgeInsets.only(top: 25),
            child: Column(
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  onTap: () {
                    setState(() {
                      _x = 0;
                    });
                  },
                  title: Text(
                    'Movie',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: customColor.hexToColor(customColor.forestBlues)),
                  ),
                  leading: Radio(
                    activeColor:
                        customColor.hexToColor(customColor.forestBlues),
                    value: 0,
                    groupValue: _x,
                    onChanged: (int value) {
                      setState(() {
                        _x = value;
                        print(_x);
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  onTap: () {
                    setState(() {
                      _x = 1;
                    });
                  },
                  title: Text('Series',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color:
                              customColor.hexToColor(customColor.forestBlues))),
                  leading: Radio(
                    activeColor:
                        customColor.hexToColor(customColor.forestBlues),
                    value: 1,
                    groupValue: _x,
                    onChanged: (int value) {
                      setState(() {
                        _x = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Visibility(
                  visible: _isLoading,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 85.0),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  color: customColor.hexToColor(customColor.forestBlues),
                  onPressed: () {
                    if (_form_key.currentState.validate()) {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        _isLoading = true;
                      });
                      // print("heyyyyyyyyyy " + _x.toString());
                      // Process data.
                      // print(myController.text);
                      getData(_myController.text, _x)
                          .then((String x) => Navigator.pushNamed(
                                  context, '/searchResults', arguments: {
                                'x': x,
                                'text': _myController.text,
                                'val': _x
                              }))
                          .then((value) {
                        _myController.clear();
                        setState(() {
                          _isLoading = false;
                        });
                      });
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<String> getData(String title, int x) async {
  final http.Response response = await http.post(
    'http://192.168.43.50:5000/search_api',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'names': title, 'stv': x.toString()}),
  );
  if (response.statusCode == 200) {
    return response.body;
  } else {
    print(response.body);
    // throw Exception('Failed to load album');
  }
}
