import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:hello/widgets/customColor.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageGridMovie extends StatelessWidget {
  final String id;
  ImageGridMovie(this.id);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    FlutterDownloader.initialize();
    return FutureBuilder(
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.waiting &&
              projectSnap.hasData == null) {
            // print('project snapshot data is: ${projectSnap.data}');
            return Center(
                child: Column(
              children: [
                Image(
                  image: AssetImage("assets/loader3.gif"),
                ),
                Text("Loading Images"),
              ],
            ));
          } else if (projectSnap.connectionState == ConnectionState.done &&
              projectSnap.data != null) {
            var f = (projectSnap.data);
            if (f == null) {
              return Container();
            } else {
              // var imagedata = [];
              var imagedata = (json.decode(f)['images'])['posters'];
              // print(imagedata.length);
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
                                    Permission.storage.status.then((value) {
                                      if (value ==
                                          PermissionStatus.undetermined) {
                                        Permission.storage
                                            .request()
                                            .isGranted
                                            .then((value) {
                                          FlutterDownloader.enqueue(
                                                  url:
                                                      "https://image.tmdb.org/t/p/original/" +
                                                          (imagedata[index]
                                                              ['file_path']),
                                                  savedDir: (dir.path),
                                                  showNotification: true,
                                                  openFileFromNotification:
                                                      true)
                                              .then((value) {
                                            Fluttertoast.showToast(
                                                msg: "Download Completed",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor:
                                                    Colors.red[400],
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          });
                                        });
                                      } else if (value ==
                                          PermissionStatus.granted) {
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
                                      }
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
                                    imageErrorBuilder: (bc, obj, stc) {
                                      return Container(
                                        alignment: Alignment.center,
                                        color: Colors.white70,
                                        width: 100,
                                        height: 150,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.error_outline,
                                              color: Colors.red,
                                            ),
                                            Text(
                                              "Error loading Image",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: "WorkSansRegular",
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      );
                                    },
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
          } else {
            return Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.4),
              child: Center(
                  child: Column(
                children: [
                  Image(
                    image: AssetImage("assets/loader4.gif"),
                    width: 50,
                  ),
                  Container(
                    height: 30,
                  ),
                  Text("Loading\nImages",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "WorkSansRegular", color: Colors.white)),
                ],
              )),
            );
            ;
          }
        },
        future: getMovieData(id));
  }
}

Future<String> getMovieData(String id) async {
  http.Response response;
  try {
    response = await http.get(
      'https://www.reviewsbyvatsa.wtf/movie_api/' + id,
    );
  } on SocketException catch (e) {
    print(e.toString());
    return null;
  } catch (e) {
    print(e);
    return null;
  }
  if (response.statusCode == 200) {
    // print(response.body);
    return response.body;
  } else {
    // print(response.body);
    return null;
  }
}
