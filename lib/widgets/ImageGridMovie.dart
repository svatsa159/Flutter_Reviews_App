import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:hello/widgets/customColor.dart';

class ImageGridMovie extends StatelessWidget {
  final String id;
  ImageGridMovie(this.id);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    FlutterDownloader.initialize();
    return FutureBuilder(
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none &&
              projectSnap.hasData == null) {
            print('project snapshot data is: ${projectSnap.data}');
            return Container();
          } else {
            var f = (projectSnap.data);
            if (f == null) {
              return Container();
            } else {
              // var imagedata = [];
              var imagedata = (json.decode(f)['images'])['posters'];
              print(imagedata.length);
              return GridView.builder(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  itemCount: imagedata.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          (orientation == Orientation.portrait) ? 1 : 2),
                  itemBuilder: (BuildContext context, int index) {
                    return GridTile(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.center,
                        child: FocusedMenuHolder(
                          menuWidth: MediaQuery.of(context).size.width * 0.30,
                          duration: Duration(milliseconds: 50),
                          menuOffset: 10.0,
                          menuItems: [
                            FocusedMenuItem(
                                title: Text("Download"),
                                trailingIcon: Icon(Icons.file_download),
                                onPressed: () {
                                  Fluttertoast.showToast(
                                      msg: "Download Started",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.red[400],
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  getExternalStorageDirectory().then((dir) {
                                    FlutterDownloader.enqueue(
                                            url:
                                                "https://image.tmdb.org/t/p/original/" +
                                                    (imagedata[index]
                                                        ['file_path']),
                                            savedDir: (dir.path),
                                            showNotification: true,
                                            openFileFromNotification: true)
                                        .then((value) {
                                      Fluttertoast.showToast(
                                          msg: "Download Completed",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.red[400],
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    });
                                  });
                                }),
                          ],
                          onPressed: () {},
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/review',
                                  arguments: {
                                    'imagedata': imagedata[index],
                                    'id': json.decode(f)['data']['id'],
                                    'genres': json.decode(f)['data']['genres'],
                                    'name': json.decode(f)['data']['title'],
                                    'bdpath': json.decode(f)['data']
                                        ['backdrop_path'],
                                    'type': 0
                                  });
                            },
                            child: Container(
                              padding: EdgeInsets.all(7),
                              color: customColor
                                  .hexToColor(customColor.waterfallEdited),
                              child: Container(
                                  padding: EdgeInsets.all(3),
                                  color: customColor
                                      .hexToColor(customColor.forestBlues),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: "assets/loader.gif",
                                    image: (imagedata[index])['file_path'] ==
                                            null
                                        ? "https://via.placeholder.com/150x200"
                                        : 'https://image.tmdb.org/t/p/w500/' +
                                            (imagedata[index])['file_path'],
                                  )),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }
        },
        future: getMovieData(id));
  }
}

Future<String> getMovieData(String id) async {
  final http.Response response = await http.get(
    'https://www.reviewsbyvatsa.wtf/movie_api/' + id,
  );
  if (response.statusCode == 200) {
    // print(response.body);
    return response.body;
  } else {
    // print(response.body);
    throw Exception('Failed to load album');
  }
}
