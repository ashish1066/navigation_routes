// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE

import 'package:flutter/material.dart';
import 'package:flyy_flutter_plugin/flyy_flutter_plugin.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

import '../data/library.dart';
import '../routing.dart';
import '../widgets/author_list.dart';

class AuthorsScreen extends StatelessWidget {
  final String title = 'Authors';

  const AuthorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: AuthorList(
          authors: libraryInstance.allAuthors,
          onTap: (author) {
           // FlyyFlutterPlugin.openFlyyOffersPage();
            //RouteStateScope.of(context).go('/author/${author.id}');
          },
        ),
      );

  void joinMeeting() async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION; // Limit video resolution to 360p

      var options = JitsiMeetingOptions(room: 'myroom1212322') // Required, spaces will be trimmed
        ..serverURL = "https://meet.jit.si"
        ..subject = "Meeting with Gunschu"
        ..userDisplayName = "My Name"
        ..userEmail = "myemail@email12234.com"
        ..userAvatarURL = "https://images.unsplash.com/photo-1604085572504-a392ddf0d86a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8b3JhbmdlJTIwZmxvd2VyfGVufDB8fDB8fA%3D%3D&w=1000&q=80" // or .png
        ..audioOnly = true
        ..audioMuted = true
        ..videoMuted = true;

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
