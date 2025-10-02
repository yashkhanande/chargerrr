import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors;

class ContainerDesign extends StatelessWidget{
  final Widget child;
  const ContainerDesign ({super.key, required this.child});
  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: Colors.grey.shade400,
              width: 0.5
          )
      ),
      child: child,
    );
  }
}