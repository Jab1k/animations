// ignore_for_file: unused_field, unused_import

import 'package:animations/infascturation/companents/zoom_lab_animation.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RiveAnimationController _controller;
  late RiveAnimationController _controllertwo;
  bool isPlaying = true;
  @override
  void initState() {
    _controller = OneShotAnimation(
      'StartLoading',
      autoplay: false,
      onStop: () => setState(
        () {
          isPlaying = false;
        },
      ),
      onStart: () => setState(() {
        isPlaying = true;
      }),
    );
    _controllertwo = SimpleAnimation("FinishLoading", autoplay: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Expanded(
                child: RiveAnimation.asset(
              'assets/ball_loader.riv',
              animations: const [
                "FinishLoading",
                'Loading',
                'StartLoading',
              ],
              antialiasing: false,
              controllers: [_controller, _controllertwo],
            )),
          ],
        ),
      ),
      floatingActionButton: Row(
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              isPlaying ? null : _controller.isActive = true;
              setState(() {});
            },
            tooltip: isPlaying ? 'Pause' : 'Play',
            child: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          ),
          FloatingActionButton(
            onPressed: () {
              _controller.dispose();
              _controllertwo.isActive = true;
              _controllertwo.dispose();
            },
          )
        ],
      ),
    );
  }
}
