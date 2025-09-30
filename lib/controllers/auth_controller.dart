import 'package:chargerrr_app/presentation/auth/login_page.dart';
import 'package:chargerrr_app/presentation/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, FirebaseAuthException, User;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
final emailController = TextEditingController();
final passwordController = TextEditingController();

var isLoading = false.obs;

final FirebaseAuth _auth = FirebaseAuth.instance;


void SignUp() async {
  try{
    isLoading.value = true;
    await _auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    Get.snackbar("Success", "SignIn Successful");
    Get.off(()=>HomePage());
  }on FirebaseAuthException catch(e) {
    Get.snackbar("failed", e.message ?? "Unknown Error");
  }finally {
    isLoading.value = false;
  }
}


void login() async {
  try{
    isLoading.value = true;
    await _auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    Get.snackbar("Success", "Login Successful");
    Get.off(()=>HomePage());
  }on FirebaseAuthException catch (e){
    Get.snackbar("failed", e.message ?? "Unknown error occurred");
  }finally{
    isLoading.value = false;
  }
}

@override
  void onClose(){
  emailController.dispose();
  passwordController.dispose();
  super.onClose();
}
void logOut() async {
  await _auth.signOut();
  Get.off(()=>LoginPage());
}

@override

  void onReady() async {
  super.onReady();
  _auth.authStateChanges().listen((User? user){
    if(user == null){
      Get.offAll(()=>LoginPage());
    }else{
      Get.offAll(()=>HomePage());
    }
  });
}


}