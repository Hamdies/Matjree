import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:matjree/layout/cubit/cubit.dart';
import 'package:matjree/layout/cubit/states.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
       return Scaffold(
         appBar: AppBar(
           title: Text(''),
         ),
            body: cubit.bottomScreens[cubit.currentIndex],
         bottomNavigationBar: BottomNavigationBar(
           onTap: (index)
           {
             cubit.changeBottom(index);
           },
           currentIndex: cubit.currentIndex,
           items: [
             BottomNavigationBarItem(
                 icon: Container(
                   width: 50,
                     height: 40,
                     child: Lottie.asset('assets/lottie/home.json')),
                 label: 'Home'
             ),
             BottomNavigationBarItem(
                 icon: Container(
                  width: 100,
                  height: 40,
                 child:Lottie.asset('assets/lottie/orders.json',height: 100)),
                 label: 'Orders'
             ),
             BottomNavigationBarItem(
                 icon: Container(
                     height: 40,
                     width: 50,
                     child: Lottie.asset('assets/lottie/cartD.json')),
                 label: 'Cart'
             ),
             BottomNavigationBarItem(
                 icon: Container(
                   width: 50,
                     height: 40,
                     child: Lottie.asset('assets/lottie/profile.json',width: 30,height: 10)),
                 label: 'Profile'
             ),
           ],
         ) ,
        );
      }
      );
  }
}
