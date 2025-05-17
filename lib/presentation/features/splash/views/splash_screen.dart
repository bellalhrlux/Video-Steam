import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_stream/core/constants/route_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(onPressed: (){
        context.go("/videos/10",);
        //context.goNamed(RouteConstants.videoDetails);
      }, child: Text("Counter")),
    );
  }
}
