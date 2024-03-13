import 'package:flutter/material.dart';

class PreloaderScreen2 extends StatefulWidget {
  const PreloaderScreen2({super.key});

  @override
  State<PreloaderScreen2> createState() => _PreloaderScreen2State();
}

class _PreloaderScreen2State extends State<PreloaderScreen2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    )..addListener(() {
        setState(() {});
      });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildCircle(double opacity, Color color) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pre-loader Animation'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCircle(1.0 - (_animation.value % 1), Colors.red),
            const SizedBox(width: 20),
            _buildCircle(1.0 - ((_animation.value + 0.25) % 1), Colors.blue),
            const SizedBox(width: 20),
            _buildCircle(1.0 - ((_animation.value + 0.5) % 1), Colors.green),
            const SizedBox(width: 20),
            _buildCircle(1.0 - ((_animation.value + 0.75) % 1), Colors.yellow),
          ],
        ),
      ),
    );
  }
}
