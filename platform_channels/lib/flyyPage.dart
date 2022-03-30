import 'package:flutter/material.dart';

class FlyyPage extends StatefulWidget {
  const FlyyPage({Key? key}) : super(key: key);

  @override
  State<FlyyPage> createState() => _FlyyPageState();
}

class _FlyyPageState extends State<FlyyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FLyy Page"),
      ),
      body: Column(
        children: [
          RaisedButton(onPressed: (){

          },
            child: const Text("Offers Page"),
          )
        ],
      ),
    );
  }
}
