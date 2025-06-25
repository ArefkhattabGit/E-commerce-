import 'package:final_poject_sw_engineering/app/app_colors.dart';
import 'package:flutter/material.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
            Icon(Icons.wifi_off,size: 40,color: AppColors.redColor),
             SizedBox(
               height: 10,
             ),
             Text('You are not connected via internet, check you network ')

          ],
        ),
      ),
    );
  }
}
