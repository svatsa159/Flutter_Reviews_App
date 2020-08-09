import 'package:flutter/material.dart';
import 'package:hello/models/Movie.dart';
import 'package:hello/widgets/newPage.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'widgets/formSubmit.dart';
import 'widgets/moviePage.dart';
import 'widgets/reviewsPage.dart';
import 'widgets/seriesPage.dart';
import 'package:hello/widgets/customColor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reviews by Vatsa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        unselectedWidgetColor: Colors.black,
        primaryColor: customColor.hexToColor(customColor.forestBlues),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => MyHomePage(title: 'Reviews\nby Vatsa'),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/searchResults': (context) => newPage(),
        '/movie': (context) => moviePage(),
        '/series': (context) => seriesPage(),
        '/review': (context) => reviewsPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColor.hexToColor(customColor.reefEncounter),
      // resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 155, left: 36, right: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(
                      fontFamily: 'AlfaSlabOne',
                      fontSize: 70,
                      color: Colors.white),
                  textAlign: TextAlign.left,
                ),
                Container(
                    margin: EdgeInsets.only(top: 140), child: formSubmit()),
              ],
            ),
          ),
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
