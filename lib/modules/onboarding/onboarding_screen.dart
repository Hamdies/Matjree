
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:matjree/modules/Login/login.dart';
import 'package:matjree/network/local/cache_helper.dart';
import 'package:matjree/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.title,
    @required this.image,
    @required this.body,
  });
}




class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    var boardController = PageController();
    List<BoardingModel> boarding = [
      BoardingModel(
        image: 'assets/lottie/logo.json',
        title: 'Matjree',
        body: 'an E-commerce app via Hamdies®',
      ),
      BoardingModel(
        image: 'assets/lottie/sales.json',
        title: 'Browse & Order our Products',
        body: 'discover our hot offers ',
      ),
      BoardingModel(
        image: 'assets/lottie/delivery.json',
        title: 'Your order is safe in our Hands',
        body: 'safety is our substantial',
      ),
      BoardingModel(
        image: 'assets/lottie/cashback.json',
        title: 'Enjoy our Cashback',
        body: 'got 15% Cashback if you use Visa',
      ),
    ];

    void submit() {
      CacheHelper.saveData(
        key: 'onBoarding',
        value: true,
      ).then((value)
      {
        if (value) {
          navigateAndFinish(
            context,
            LoginScreen(),
          );
        }
      });
    }
    bool isLast = false;
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: submit,
            text: 'skip', color: Colors.red,
          ),
        ],
      ),
      body:Padding(
        padding:  EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.deepOrange,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                    onPressed: () {
                      if (isLast)
                      {
                        submit();
                      } else {
                        boardController.nextPage(
                          duration: Duration(
                            milliseconds: 700,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: Lottie.asset('assets/lottie/rightArrow.json')
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Lottie.asset(
          ('${model.image}'),
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
            fontSize: 14.0,
            color: Colors.grey
        ),
      ),
      SizedBox(
        height: 70.0,
      ),
    ],
  );
}


