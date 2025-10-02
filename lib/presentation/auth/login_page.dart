import 'package:chargerrr_app/components/app_buttons.dart';
import 'package:chargerrr_app/components/app_colors.dart';
import 'package:chargerrr_app/controllers/auth_controller.dart';
import 'package:chargerrr_app/presentation/auth/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoginView());
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors().appPrimary
                    ),
                    child: Image.asset('assets/energy.png',height: 40,color: Colors.white,),
                  ),
                  Text("Chargerrr",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800,color: Colors.green.shade800),),
                  Text("Find EV charging station near you",style: TextStyle(fontSize:16,color: Colors.grey ),),
                  const SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 0.5,
                        strokeAlign: 4,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Sign in to continue to your account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email Address",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: authController.emailController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.mail),
                                hint: Text("Enter your email"),
                                filled: true,
                                fillColor: Colors.grey.withValues(alpha: 0.1),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                alignLabelWithHint: true,
                              ),
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Password",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              obscureText: true,
                              controller: authController.passwordController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock_outline),
                                hint: Text("Enter your password"),
                                filled: true,
                                fillColor: Colors.grey.withValues(alpha: 0.1),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                alignLabelWithHint: true,
                              ),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        Obx(()=>authController.isLoading.value ? CircularProgressIndicator() :
                        AppButton(buttonTitle: "Sign In",
                            onPressed: (){
                          Get.find<AuthController>().login();
                            }
                        )),

                        TextButton(
                          onPressed: () {
                            Get.to(()=>SignupPage());
                          },
                          child: Text(
                            "Don't have an account? Sign up for free",textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
