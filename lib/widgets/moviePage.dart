import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello/models/Movie.dart';
import 'package:hello/widgets/customColor.dart';
import 'ImageGridMovie.dart';

class moviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dynamic mv = ModalRoute.of(context).settings.arguments;
    // print(mv.name);
    return Scaffold(
      backgroundColor: customColor.hexToColor(customColor.forestBlues),
      appBar: AppBar(
        backgroundColor: customColor.hexToColor(customColor.forestBlues),
        title: Text(
          mv.name,
          style: TextStyle(
              color: Colors.white, fontFamily: 'alfaSlabOne', fontSize: 20),
          overflow: TextOverflow.ellipsis,
        ),
        // leading: null,
      ),
      body: ImageGridMovie(mv.id),
    );
  }
}
