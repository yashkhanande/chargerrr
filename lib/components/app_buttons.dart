import 'package:chargerrr_app/components/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget{
  final String buttonTitle;
  final VoidCallback onPressed;
  const AppButton ({super.key, required this.buttonTitle, required this.onPressed});
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors().appPrimary,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Center(child: Text(buttonTitle,
                 style: TextStyle(fontWeight: FontWeight.bold,
                 color: Colors.white,
                 fontSize: 16,
       ))),
      ),
    );
  }
}