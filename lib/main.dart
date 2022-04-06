import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/themes.dart';

import 'layout/cubit/cubit.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

   bool isBoarding = CacheHelper.getBoolean(key:'onBoarding');
   token = CacheHelper.getData(key:'token');
   print(token);



  if(isBoarding != null)
  {
    if(token !=null) {
      widget= ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  }else{
    widget =OnBoardingScreen();
  }

  runApp( MyApp(startwidget: widget));
}

class MyApp extends StatelessWidget {

  final Widget startwidget;
   MyApp({this.startwidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AppCubit()),
        BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData()),
      ],

      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startwidget,
          );
        },
      ),
    );
  }
}
