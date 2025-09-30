import 'package:chargerrr_app/controllers/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("HomePage"),
            IconButton(onPressed: (){
              authController.logOut();
            }, icon: Icon(Icons.exit_to_app))
          ],
        ),
      ),
    );
  }
}
