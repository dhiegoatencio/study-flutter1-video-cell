import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testflutter/details.page.dart';
import 'dart:convert';

import 'package:testflutter/views/videoCell.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var _isLoading = true;
  var videos;

  MyAppState() {
    _fetchData();
  }

  _fetchData() async {
    print("fetching data");

    final url = "https://api.letsbuildthatapp.com/youtube/home_feed";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final map = json.decode(response.body);

      setState(() {
        _isLoading = false;
        videos = map["videos"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Youtube videos"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: () {
                print("pressed");
                setState(() {
                  //
                  _isLoading = !_isLoading;
                });
                _fetchData();
              },
            )
          ],
        ),
        body: Center(
            child: _isLoading
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: this.videos != null ? this.videos.length : 0,
                    itemBuilder: (context, i) {
                      final video = this.videos[i];
                      return FlatButton(
                          padding: EdgeInsets.all(0.0),
                          child: VideoCell(video),
                          onPressed: () {
                            final id = video["id"];
                            print("video cell tapped $id");
                            Navigator.push(context,
                                MaterialPageRoute(builder: (content) {
                              return DetailsPage(
                                id,
                                key: Key(id.toString()),
                              );
                            }));
                          });
                    },
                  )),
      ),
    );
  }
}

class DetailPage {
}
