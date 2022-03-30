// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:platform_channels/src/add_pet_details.dart';
import 'package:platform_channels/src/event_channel_demo.dart';
import 'package:platform_channels/src/method_channel_demo.dart';
import 'package:platform_channels/src/pet_list_screen.dart';
import 'package:platform_channels/src/platform_image_demo.dart';

void main() {
  runApp(const PlatformChannelSample());
}

class PlatformChannelSample extends StatelessWidget {
  const PlatformChannelSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/methodChannelDemo': (context) => const MethodChannelDemo(),
        '/eventChannelDemo': (context) => const EventChannelDemo(),
        '/platformImageDemo': (context) => const PlatformImageDemo(),
        '/petListScreen': (context) => const PetListScreen(),
        '/addPetDetails': (context) => const AddPetDetails(),
      },
      title: 'Platform Channel Sample',
      theme: ThemeData(
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.blue[500],
        ),
      ),
      home: const HomePage(),
    );
  }
}

class DemoInfo {
  final String demoTitle;
  final String demoRoute;

  DemoInfo(this.demoTitle, this.demoRoute);
}

List<DemoInfo> demoList = [
  DemoInfo(
    'MethodChannel Demo',
    '/methodChannelDemo',
  ),
  DemoInfo(
    'EventChannel Demo',
    '/eventChannelDemo',
  ),
  DemoInfo(
    'Platform Image Demo',
    '/platformImageDemo',
  ),
  DemoInfo(
    'BasicMessageChannel Demo',
    '/petListScreen',
  )
];
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static MethodChannel methodChannel = const MethodChannel('methodChannelDemo');
  static const int STAGE = 0;
  static const int PRODUCTION = 1;

  static const String FLYY_PACKAGE_NAME = "flyy_package_name";

  static const String FLYY_INIT = "flyy_init";
  static const String FLYY_SET_USER = "flyy_set_user";
  static const String FLYY_OPEN_OFFERS_SCREEN = "flyy_open_offers_screen";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> initFlyySDK() async {
    methodChannel.invokeMethod<void>(FLYY_PACKAGE_NAME, {"package-name": packageName});
    methodChannel.invokeMethod<void>(
        FLYY_INIT, {"partner-token": partnerToken, "environment": environment});
    final String? result =
        await methodChannel.invokeMethod<String>(FLYY_SET_USER, {"ext-uid": externalUserId});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platform Channel Sample'),
      ),
      body: Column(
        children: [
          RaisedButton(onPressed: (){
            methodChannel.invokeMethod<void>(FLYY_OPEN_OFFERS_SCREEN);
          },
            child: const Text("Offers Page"),
          )
        ],
      ),
    );
  }
}

/// This widget is responsible for displaying the [ListTile] on [HomePage].
class DemoTile extends StatelessWidget {
  final DemoInfo demoInfo;

  const DemoTile(this.demoInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(demoInfo.demoTitle),
      onTap: () {
        Navigator.pushNamed(context, demoInfo.demoRoute);
      },
    );
  }
}
