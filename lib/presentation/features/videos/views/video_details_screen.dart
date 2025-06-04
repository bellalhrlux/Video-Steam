import 'package:flutter/material.dart';

class VideoDetailsScreen extends StatefulWidget {
  String videoId;
  VideoDetailsScreen({super.key,required this.videoId});

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Video ID : ${widget.videoId}"),
    );
  }
}
