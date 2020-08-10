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
                FadeInImage.assetNetwork(
                  imageErrorBuilder: (bc, obj, stc) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.white70,
                      width: 100,
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                          ),
                          Text(
                            "Error loading Image",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "WorkSansRegular", fontSize: 12),
                          )
                        ],
                      ),
                    );
                  },
                  placeholder: "assets/loader.gif",
                  image: datas.posterpath == null
                      ? "https://via.placeholder.com/150x200"
                      : 'https://image.tmdb.org/t/p/w500/' + datas.posterpath,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                // Image.network(
                //   datas.posterpath == null
                //       ? "https://via.placeholder.com/150x200"
                //       : 'https://image.tmdb.org/t/p/w500/' + datas.posterpath,
                //   fit: BoxFit.cover,
                //   width: 100,
                // ),
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
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                                fontFamily: 'WorkSans')),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text("Release Date : " + datas.date,
                              maxLines: 3,
                              softWrap: true,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'WorkSansRegular',
                                  letterSpacing: 1.1)),
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
