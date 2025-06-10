// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:yourseatgraduationproject/data/hive_keys.dart';
import 'package:yourseatgraduationproject/data/hive_storage.dart';
import 'package:yourseatgraduationproject/features/user_flow/auth/presentation/views/sign_in.dart';
import 'package:yourseatgraduationproject/features/user_flow/home/presentation/views/home_layout.dart';
import 'package:yourseatgraduationproject/features/user_flow/onBoarding/presentation/views/onboarding.dart';
import 'package:yourseatgraduationproject/utils/navigation.dart';
import 'package:yourseatgraduationproject/widgets/scaffold/scaffold_f.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Bubble> bubbles;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..forward();

    bubbles = List.generate(90, (index) => Bubble());

    _timer = Timer(const Duration(seconds: 4), _navigate);
  }

  void _navigate() {
    if (HiveStorage.get(HiveKeys.passUserOnboarding) == false) {
      navigateAndReplace(context: context, screen: const OnBoarding());
    } else if (HiveStorage.get(HiveKeys.role) == "" ||
        HiveStorage.get(HiveKeys.role) == null) {
      navigateAndReplace(
        context: context,
        screen: const SignIn(),
      );
    } else {
      navigateAndReplace(
        context: context,
        screen: const HomeLayout(),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldF(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            ...bubbles.map((bubble) => AnimatedBubble(
                  controller: _controller,
                  bubble: bubble,
                )),
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _controller.value,
                    child: Opacity(
                      opacity: _controller.value,
                      child: Image.asset(
                        'assets/images/splash.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Bubble {
  final double size;
  final Color color;
  final Offset startPosition;
  final Offset endPosition;

  Bubble()
      : size = 180 + (120 * Random().nextDouble()),
        color = _getRandomColor(),
        startPosition = Offset(
          Random().nextDouble() * 2 - 0.5,
          Random().nextDouble() * 2 - 0.5,
        ),
        endPosition = Offset(
          Random().nextDouble() * 2 - 0.5,
          Random().nextDouble() * 2 - 0.5,
        );

  static Color _getRandomColor() {
    List<Color> colors = [
      Color(0xFF381362),
      Color(0xFF6E0ADD),
      Color(0xFF4B0082),
      Color(0xFF7A1FC8),
    ];
    return colors[Random().nextInt(colors.length)];
  }
}

class AnimatedBubble extends StatelessWidget {
  final Bubble bubble;
  final AnimationController controller;

  const AnimatedBubble({
    super.key,
    required this.bubble,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final double progress = controller.value;
        final double startX = bubble.startPosition.dx * screenSize.width;
        final double startY = bubble.startPosition.dy * screenSize.height;
        final double endX = bubble.endPosition.dx * screenSize.width;
        final double endY = bubble.endPosition.dy * screenSize.height;

        final double newX = startX + (endX - startX) * progress;
        final double newY = startY + (endY - startY) * progress;

        final double scale = 1.0 - progress;
        final double opacity =
            1.0 - (progress > 0.6 ? (progress - 0.6) * 2 : 0);

        return Positioned(
          left: newX,
          top: newY,
          child: Transform.scale(
            scale: scale,
            child: Opacity(
              opacity: opacity,
              child: Container(
                width: bubble.size,
                height: bubble.size,
                decoration: BoxDecoration(
                  color: bubble.color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
