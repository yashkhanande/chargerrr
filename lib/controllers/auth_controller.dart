import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
final emailController = TextEditingController();
final passwordController = TextEditingController();

var isLoading = false.obs;

void login() async {
  if(emailController.text.isEmpty || passwordController.text.isEmpty){
    Get.snackbar("Error", "Email and Password Required");
    return;
  }
  isLoading.value = true;
  await Future.delayed(Duration(seconds: 2));

  if(passwordController.text == "1234" ){
    Get.snackbar("Success", "Login Succesfull");
    Get.offAllNamed("/home");
  }else{
    Get.snackbar("Error", "Invalid Credentials");
  }
  isLoading.value = false;
}

@override
  void onClose(){
  emailController.dispose();
  passwordController.dispose();
  super.onClose();
}


}