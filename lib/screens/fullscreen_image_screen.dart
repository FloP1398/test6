import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';
import 'package:test6/services/networking.dart';

NetworkHelper networkHelper;

class FullscreenScreen extends StatefulWidget {
  FullscreenScreen({@required this.imageweb});

  final String imageweb;

  @override
  _FullscreenScreenState createState() => _FullscreenScreenState(imageweb);
}

class _FullscreenScreenState extends State<FullscreenScreen> {
  _FullscreenScreenState(this.imageweb);
  String imageweb;

  @override
  Widget build(BuildContext context) {
    networkHelper = NetworkHelper(imageweb);
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Center(
          child: PhotoView(
            imageProvider: (networkHelper.getStatusCode() != 200)
                ? AssetImage('images/no_image.png')
                : NetworkImage(imageweb),
            minScale: 1.0,
            maxScale: 2.0,
            initialScale: 1.0,
          ),
        ),
      ),
    );
  }
}
