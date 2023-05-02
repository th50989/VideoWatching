import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/getUserData.dart';
import '../models/infoVideo.dart';
import '../widgets/videoCard.dart';

class likedVideo extends StatefulWidget {
  final bool isLogin;
  const likedVideo({super.key, required this.isLogin});

  @override
  State<likedVideo> createState() => _likedVideoState();
}

class _likedVideoState extends State<likedVideo> {
  UserData? currentUser;

  Future<infoVideo> getInfoVideo(String docId, infoVideo info) async {
    var collection = FirebaseFirestore.instance.collection('video_list');
    var doc = collection.doc(docId).get();
    await doc.then((DocumentSnapshot document) {
      info.description = document['description'];
      info.title = document['title'];
      info.url = document['videoUrl'];
      info.vidId = document.id;
      info.userId = document['ownerId'];
      info.types = document['type'];
      info.ownerName = document['ownerName'];
      info.likedCount = document['likedCount'];
    });
    return info;
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      currentUser = UserData.getCurrentUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('liked_video').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Flexible(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        infoVideo info = infoVideo();
                        if (snapshot.data!.docs[index]['userId'] ==
                            currentUser!.docId) {
                          return FutureBuilder(
                              future: getInfoVideo(
                                  snapshot.data!.docs[index]['vidId'], info),
                              builder: (context, snap) {
                                if (snap.hasData) {
                                  return videoCard(
                                    users: currentUser,
                                    infoVid: info,
                                    isLogin: widget.isLogin,
                                  );
                                }
                                return Center(
                                  child: Transform.scale(
                                    scale: 1,
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              });
                        }
                        return const SizedBox(
                          height: 0,
                        );
                      }),
                ),
              ],
            );
          } else {
            return Center(child: const Text('No data'));
          }
        });
  }
}
