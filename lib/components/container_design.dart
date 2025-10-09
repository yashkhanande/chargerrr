import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors;

class ContainerDesign extends StatelessWidget{
  final Widget child;
  const ContainerDesign ({super.key, required this.child});
  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E).withValues(alpha: .85), // light black
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}