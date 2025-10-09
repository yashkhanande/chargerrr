import 'package:chargerrr_app/components/app_textfield.dart';
import 'package:chargerrr_app/components/container_design.dart';
import 'package:chargerrr_app/controllers/auth_controller.dart';
import 'package:chargerrr_app/presentation/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/app_buttons.dart';
import '../../components/app_colors.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
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
                  ContainerDesign(
                    // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(12),
                    //   color: Colors.white,
                    //   border: Border.all(
                    //     color: Colors.grey.shade400,
                    //     width: 0.5,
                    //     strokeAlign: 4,
                    //   ),
                    // ),
                    child: Column(
                      children: [
                        Text(
                          'Create Account',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Sign up to start finding station",
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
                              "Name ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            AppTextfield(
                              type: TextInputType.name,
                              hint: "Enter Your Full Name",
                              icon: Icons.person,
                              controller: authController.nameController,
                              password: false,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Email Address",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            AppTextfield(
                              type: TextInputType.emailAddress,
                              hint: "Enter Your email",
                              icon: Icons.mail,
                              controller: authController.emailController,
                              password: false,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Password",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            AppTextfield(
                              type: TextInputType.visiblePassword,
                              hint: "Enter your password",
                              icon: Icons.lock_outline,
                              controller: authController.passwordController,
                              password: true,
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        Obx(()=>authController.isLoading.value ? CircularProgressIndicator() :
                        AppButton(buttonTitle: "Create Account",
                            onPressed: (){
                              Get.find<AuthController>().SignUp();
                            }
                        ))
                        ,
                        TextButton(
                          onPressed: () {
                            Get.to(()=>LoginPage());
                          },
                          child: Text(
                            "Already Member? Sign in",textAlign: TextAlign.center,
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
      )
    );
  }
}
