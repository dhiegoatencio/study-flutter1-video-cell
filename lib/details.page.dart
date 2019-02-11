
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testflutter/views/videoCell.dart';

class DetailsPage extends StatefulWidget {

  final id;

  DetailsPage(this.id, {Key key}): super(key: key);

  @override
  _DetailsPageState createState() {
    print("received id $id");
    return _DetailsPageState();
  }
}

class _DetailsPageState extends State<DetailsPage> {

  var _isLoading = true;
  var _videos;

  _fetchData(String id) async {

    print("fetching details");

    final url = "https://api.letsbuildthatapp.com/youtube/course_detail?id=$id";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      this._videos = json.decode(response.body);
      setState(() {
        this._isLoading = false; 
      });
    }
  }

  @override
  void initState() { 
    final String id = widget.id.toString();
    _fetchData(id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
      ),
      body: Center(
        child: _isLoading ? CircularProgressIndicator()
          : ListView.builder(
            itemCount: this._videos != null ? this._videos.length : 0,
            itemBuilder: (context, i) {
              return FlatButton(
                padding: EdgeInsets.all(0.0),
                child: VideoCell(_videos[i]),
                onPressed: () {
                  print("details pressed");
                },
              );
            },
          ),
      ),
    );
  }

}
