import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello/models/Movie.dart';
import 'package:hello/widgets/customColor.dart';
import 'ImageGridSeries.dart';

class seriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dynamic mv = ModalRoute.of(context).settings.arguments;
    // print(mv.name);
    return Scaffold(
      backgroundColor: customColor.hexToColor(customColor.forestBlues),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: customColor.hexToColor(customColor.forestBlues),
        title: Text(
          mv.name,
          style: TextStyle(
              color: Colors.white, fontFamily: 'alfaSlabOne', fontSize: 20),
          overflow: TextOverflow.ellipsis,
        ),
        // leading: null,
      ),
      body: ImageGridSeries(mv.id),
    );
  }
}
