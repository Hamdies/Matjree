

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:matjree/modules/Login/login.dart';
import 'package:matjree/network/local/cache_helper.dart';

import 'components.dart';

const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const primaryColor = Color(0xfffb5722);
const sColor = Color(0xffEFF2F6);

void signOut(context)
{
  CacheHelper.removeData(
    key: 'token',
  ).then((value)
  {
    if (value)
    {
      navigateAndFinish(
        context,
        LoginScreen(),
      );
    }
  });

  void printFullText(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

}

String token ='';

final List<String> imgList = [
  'https://img.freepik.com/free-vector/retro-futuristic-cyber-monday_52683-47013.jpg?size=664&ext=jpg&ga=GA1.2.1050610035.1626248030',
  'https://img.freepik.com/free-vector/gradient-sale-instagram-story-collection_52683-66229.jpg?size=626&ext=jpg',
  'https://img.freepik.com/free-vector/instagram-stories-set-with-fashion-sales_52683-40648.jpg?size=626&ext=jpg',
];


final List<Widget> imageSliders = imgList
    .map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.network(item, fit: BoxFit.cover, width: 1000.0),

          ],
        )),
  ),
))
    .toList();



