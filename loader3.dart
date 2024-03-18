import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Spinner Loading Animation',
      home: CustomLoader3(),
    ),
  );
}

class CustomLoader3 extends StatefulWidget {
  const CustomLoader3({super.key});
  @override
  State<CustomLoader3> createState() => _CustomLoader3State();
}

class _CustomLoader3State extends State<CustomLoader3>
    with TickerProviderStateMixin {
  late List<AnimationController> controllers;
  late List<Animation<double>> animations;

  @override
  void initState() {
    super.initState();
    controllers = [];
    animations = [];

    List<int> durations = [6, 3, 2, 2, 1];
    for (var duration in durations) {
      var controller = AnimationController(
          vsync: this, duration: Duration(seconds: duration));
      controllers.add(controller);

      var animation = Tween<double>(begin: -pi, end: pi).animate(controller)
        ..addListener(() {
          setState(() {});
        })
        ..addStatusListener(
          (status) {
            if (status == AnimationStatus.completed) {
              controller.repeat();
            } else if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          },
        );

      animations.add(animation);
      controller.forward();
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          child: CustomPaint(
            painter: MyPainter(
              animations[0].value,
              animations[1].value,
              animations[2].value,
              animations[3].value,
              animations[4].value,
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double firstAngle;
  final double secondAngle;
  final double thirdAngle;
  final double fourthAngle;
  final double fifthAngle;

  MyPainter(
    this.firstAngle,
    this.secondAngle,
    this.thirdAngle,
    this.fourthAngle,
    this.fifthAngle,
  );

  @override
  void paint(Canvas canvas, Size size) {
    Paint myArc = Paint()
      ..color = const Color(0xFF3BB419)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    List<Rect> rects = [
      Rect.fromLTRB(0, 0, size.width, size.height),
      Rect.fromLTRB(
          size.width * .1, size.height * .1, size.width * .9, size.height * .9),
      Rect.fromLTRB(
          size.width * .2, size.height * .2, size.width * .8, size.height * .8),
      Rect.fromLTRB(
          size.width * .3, size.height * .3, size.width * .7, size.height * .7),
      Rect.fromLTRB(
          size.width * .4, size.height * .4, size.width * .6, size.height * .6),
    ];

    List<double> angles = [
      firstAngle,
      secondAngle,
      thirdAngle,
      fourthAngle,
      fifthAngle
    ];

    for (int i = 0; i < rects.length; i++) {
      canvas.drawArc(
        rects[i],
        angles[i],
        2,
        false,
        myArc,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
