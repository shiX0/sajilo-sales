import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final bool isActive;

  const CustomCard({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap,
      onTap: onTap,
      child: SizedBox(
        width: 120, // Fixed width
        height: 120, // Fixed height
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? Colors.blue[900] : Colors.grey[800],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isActive ? const Color(0xFF313D53) : Colors.transparent,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: isActive ? Colors.blue[200] : Colors.grey[500],
                  size: 30,
                ),
                const SizedBox(height: 30),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
