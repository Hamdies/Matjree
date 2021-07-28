import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjree/layout/cubit/states.dart';
import 'package:matjree/models/home_model.dart';
import 'package:matjree/modules/cart/cart_screen.dart';
import 'package:matjree/modules/orders/orders_screens.dart';
import 'package:matjree/modules/products/product_screen.dart';
import 'package:matjree/modules/profile/profile_screen.dart';
import 'package:matjree/network/end_points.dart';
import 'package:matjree/network/remote/dio_helper.dart';
import 'package:matjree/shared/components/components.dart';
import 'package:matjree/shared/components/constants.dart';


class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitalState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens =
  [
    ProductsScreen(),
    OrdersScreen(),
    CartScreen(),
    ProfileScreen(),

  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavBarState());
  }

  HomeModel homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
        url: HOME,
        token: token
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites
        });
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

}
