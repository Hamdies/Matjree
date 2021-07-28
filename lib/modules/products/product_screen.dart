import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:matjree/layout/cubit/cubit.dart';
import 'package:matjree/layout/cubit/states.dart';
import 'package:matjree/models/home_model.dart';
import 'package:matjree/shared/components/components.dart';
import 'package:matjree/shared/components/constants.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null,
            builder: (context)=>productsBuilder(ShopCubit.get(context).homeModel,context),
            fallback: (context)=> Center(child: Lottie.asset('assets/lottie/loader.json',height: 150,width: 150),)
        );
      },
    );
  }
  Widget productsBuilder(HomeModel model,context){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: imageSliders,
            options:
              CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                height: 150,
                reverse: false,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayInterval: Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1
              ),
          ),
          SizedBox(height: 10),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10),
            child: Text('Categories',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
          ),
          Categories(),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10),
            child: Text('Latest Products',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset.zero,
                  blurRadius: 4.0
                )
              ]
            ),
            child: GridView.count(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1/1.60,
                children: List.generate(model.data.products.length,
                (index) => buildGridProduct(model.data.products[index],context))
            ),
          )
        ],
      ),
    );
  }
  Widget buildGridProduct(ProductModel model,context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: double.infinity,
              height: 200.0,
            ),
            if (model.discount != 0)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}\$',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice.round()}\$',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                      onPressed: (){

                      },
                      icon: ShopCubit.get(context).favorites[model.id] ? Lottie.asset('assets/lottie/fav2.json',repeat: false,):Lottie.asset('assets/lottie/favF.json'),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}