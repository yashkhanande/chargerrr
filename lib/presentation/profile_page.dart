import 'package:chargerrr_app/controllers/auth_controller.dart';
import 'package:chargerrr_app/presentation/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage ({super.key});
  @override
  Widget build(BuildContext context){
    AuthController authController = Get.find();
    final user = authController.currentUser.value;
    return Scaffold(

      body: SafeArea(child:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              child: Image.asset('assets/boy.png',),
            ),
            Text("Name : ${authController.userData.value!['name']}"),
            Row(
              children: [
                Text('Email : ' ,style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 16),),
                Text(user?.email ?? "user"),
              ],
            ),

            Row(
              children: [
                TextButton.icon(onPressed: (){
                  Get.offAll(()=>LoginPage());
                }, label: Row(
                  children: [
                    Text("LogOut"),
                    const SizedBox(width: 10,),
                    Icon(Icons.exit_to_app)
                  ],
                ))

              ],
            )
          ],
        ),
      )),
    );
  }
}