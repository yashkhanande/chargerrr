import 'package:chargerrr_app/presentation/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  const MyAppBar ({super.key});

  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 50,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                  color: AppColors().appPrimary
              ),
              child: Image.asset('assets/energy.png',height: 50,color: Colors.white,),
            ),
            const SizedBox(width: 10,),
            Text("Chargerrr",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w800,color: Colors.green.shade800),),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border : Border.all(
                  color: Colors.grey,
                  width: 0.3
                )
              ),
              child: IconButton(onPressed: (){
                Get.to(()=>ProfilePage());
              }, icon: Icon(Icons.person,size: 28,),
              ),
            )
          ],
        ),
      ),
    );
  }
}