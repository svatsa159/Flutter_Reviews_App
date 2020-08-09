import 'package:flutter/material.dart';
import 'package:hello/models/Movie.dart';
import 'package:hello/widgets/customColor.dart';

class myGrid extends StatelessWidget {
  final List<Movie> data;
  final int val;
  myGrid(this.data, this.val);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: this.data.map((Movie datas) {
        // print(datas.posterpath);
        return Card(
          color: customColor.hexToColor(customColor.forestBlues),
          elevation: 10,
          child: InkWell(
            splashColor: Colors.redAccent,
            onTap: () {
              if (val == 0)
                Navigator.pushNamed(context, '/movie', arguments: datas);
              else
                Navigator.pushNamed(context, '/series', arguments: datas);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  datas.posterpath == null
                      ? "https://via.placeholder.com/150x200"
                      : 'https://image.tmdb.org/t/p/w500/' + datas.posterpath,
                  fit: BoxFit.cover,
                  width: 100,
                ),
                Container(
                  // color: Colors.cyan,
                  padding:
                      EdgeInsets.only(left: 20, right: 5, top: 10, bottom: 30),
                  constraints: new BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 130),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      // direction: Axis.vertical,
                      // textDirection: TextDirection.ltr,
                      children: [
                        Text(datas.name,
                            maxLines: 3,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style:
                                TextStyle(fontSize: 30, color: Colors.black)),
                        Text(
                          "Release Date : " + datas.date,
                          maxLines: 3,
                          softWrap: true,
                          textAlign: TextAlign.left,
                        )
                      ]),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
