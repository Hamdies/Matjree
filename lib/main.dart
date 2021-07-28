import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjree/layout/cubit/cubit.dart';
import 'package:matjree/layout/shop_layout.dart';
import 'package:matjree/modules/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:matjree/network/local/cache_helper.dart';
import 'package:matjree/shared/bloc_obsrever.dart';
import 'package:matjree/shared/style/themes.dart';
import 'modules/Login/login.dart';
import 'network/remote/dio_helper.dart';

void main() async{
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  String token = CacheHelper.getData(key: 'token');
  Widget widget;
  print(onBoarding);

  if(onBoarding!=null)
  {
    if(token!=null) widget = HomeLayout();
    else widget = LoginScreen();
  }else{
    widget = OnBoardingScreen();
  }
  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({this.startWidget});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopCubit()..getHomeData(),
       child: MaterialApp(
          theme: lightTheme,
          debugShowCheckedModeBanner: false,
          home:  startWidget,
          
        ),
    );
  }
}
