import 'package:chargerrr_app/presentation/auth/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage ({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          IconButton(onPressed: (){
            Get.offAll(()=>LoginPage());
          }, icon: Icon(Icons.exit_to_app))
        ],
      )),
    );
  }
}