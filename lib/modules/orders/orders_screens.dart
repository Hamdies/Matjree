import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:matjree/shared/components/constants.dart';

class OrdersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/mt.json'),
            Text('You have no orders Yet',style: TextStyle(color: kSecondaryColor,fontSize: 20),),

          ],
        ),
      ),
    );
  }
}
