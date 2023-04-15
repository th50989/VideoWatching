import 'dart:io';

import 'package:do_an/models/infoVideo.dart';
import 'package:do_an/pages/watchingPage.dart';
import 'package:do_an/values/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class videoCard extends StatefulWidget {
  final infoVideo infoVid;
  // final String uRLVideo;
  // final String title;
  // final String des;
  // final String vidId;
  const videoCard(
      {super.key,
      // required this.uRLVideo,
      // required this.title,
      // required this.des,
      // required this.vidId,
      required this.infoVid});

  @override
  State<videoCard> createState() => _videoCardState();
}

class _videoCardState extends State<videoCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      child: InkWell(
        onTap: () {
          print(widget.infoVid.vidId);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => watchingPage(
                        info: widget.infoVid,
                      )));
        },
        child: Column(
          children: [
            ListTile(
              isThreeLine: true,
              leading: CircleAvatar(),
              title: Text(widget.infoVid.title!),
              subtitle: Text(widget.infoVid.description!),
              trailing: Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}
