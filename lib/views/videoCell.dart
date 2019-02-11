import 'package:flutter/material.dart';

class VideoCell extends StatelessWidget {
  final video;

  VideoCell(this.video);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      new Container(
        padding: EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              video["imageUrl"],
            ),
            Container(height: 8.0),
            new Text(
              video["name"],
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      new Divider()
    ]);
  }
}
