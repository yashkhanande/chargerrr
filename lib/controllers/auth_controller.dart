import 'package:chargerrr_app/presentation/auth/login_page.dart';
import 'package:chargerrr_app/presentation/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException, User, UserCredential;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  var currentUser = Rx<User?>(null);
  var userData = Rx<Map<String, dynamic>?>(null);

  var isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void SignUp() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        nameController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter name, email and password ",
        backgroundColor: Colors.redAccent.withValues(alpha: 0.1),
        colorText: Colors.red,
      );
      return;
    }
    try {
      isLoading.value = true;
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'name': nameController.text, 'email': emailController.text});

          final doc = await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).get();

          if(doc.exists){
            userData.value = doc.data();
          }
      Get.snackbar(
        "Success",
        "SignUp Successful",
        titleText: Text(
          "Success",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
        messageText: Text(
          "SignUp Successful",
          style: TextStyle(
            fontSize: 16,
            color: Colors.green,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
      Get.off(() => HomePage());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("failed", e.message ?? "Unknown Error");
    } finally {
      isLoading.value = false;
    }
  }

  void login() async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (doc.exists) {
        userData.value = doc.data();
      }

      Get.snackbar(
        "Success",
        "Login Successful",
        titleText: Text(
          "Success",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
        messageText: Text(
          "Login Successful",
          style: TextStyle(
            fontSize: 16,
            color: Colors.green,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
      Get.off(() => HomePage());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("failed", e.message ?? "Unknown error occurred");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void logOut() async {
    await _auth.signOut();
    Get.off(() => LoginPage());
  }

  @override
  void onReady() async {
    super.onReady();
    _auth.authStateChanges().listen((User? user) async {
      currentUser.value = user;
      if (user == null) {
        Get.offAll(() => LoginPage());
      } else {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (doc.exists) {
          userData.value = doc.data();
        }

        Get.offAll(() => HomePage());
      }
    });
  }
}
