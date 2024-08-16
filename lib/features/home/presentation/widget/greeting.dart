import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GreetingCard extends StatelessWidget {
  final String name;

  const GreetingCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.95, end: 1.05),
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      onEnd: () {
        // Loop the animation indefinitely
        Future.delayed(const Duration(seconds: 0), () {
          (context as Element).markNeedsBuild();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: SizedBox(
          height: 150,
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hello, $name',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome back to Sajilo Sales!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.transparent,
                  shadows: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                    ),
                  ],
                  size: 40,
                ),
              ),
              // const Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text(
              //     'Ready to manage your sales today?',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 20,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
