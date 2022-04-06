import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final  String image;
  final  String title;
  final  String body;

  BoardingModel(
       this.image,
       this.title,
       this.body
      );


}

class OnBoardingScreen extends StatefulWidget {


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController =PageController();

  List<BoardingModel> boarding =[
    BoardingModel('assets/images/on_boarding.jpg','Screen1','body1'),
    BoardingModel('assets/images/on_boarding.jpg','Screen2','body2'),
    BoardingModel('assets/images/on_boarding.jpg','Screen3','body3'),
  ];

  bool isLast =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            defaultTextButton(
                onPressed: (){
                  onSubmit();
                },
              text: "SKIP"
            )
          ],
        ),
        body:Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (int index){
                    if(index == boarding.length-1){
                      setState(() {
                        isLast =true;
                      });
                    }else{
                      setState(() {
                        isLast =false;
                      });
                    }
                  },
                  controller: boardController,
                  itemBuilder: (context,index){
                    return buildOnBoardingItem(boarding[index]);
                  },
                  itemCount: 3,
                ),
              ),
              const SizedBox(height: 40,),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.blue,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5.0
                    ),
                    count: boarding.length,
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: (){
                      if(isLast){
                        onSubmit();
                      }else{
                        boardController.nextPage(
                            duration: const Duration(
                                milliseconds: 750
                            ),
                            curve: Curves.fastLinearToSlowEaseIn
                        );
                      }

                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  )
                ],
              ),
            ],
          ),
        )
    );
  }

  Widget buildOnBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      Expanded(
        child: Image(
          image:AssetImage(model.image) ,
        ),
      ),

      Text(
        model.title,
        style: const TextStyle(fontSize: 24,fontFamily: 'CHEDROS_Regular'),
      ),
      const SizedBox(height: 15),
      Text(
        model.body,
        style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
      ),
    ],
  );



  void onSubmit()
  {
    CacheHelper.saveData(
        key: 'onBoarding',
        value: true
    ).then((value){
       if(value){
         navigateToAndFinish(context,  ShopLoginScreen());
       }
    });

  }


}
