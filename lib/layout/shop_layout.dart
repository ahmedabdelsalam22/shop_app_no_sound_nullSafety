import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import 'cubit/cubit.dart';


class ShopLayout extends StatelessWidget {
  const ShopLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){

        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
              title:const Text('Shopping'),
            actions: [
              IconButton(
                  onPressed:(){
                    navigateTo(context, SearchScreen());
                  } ,
                  icon: const Icon(Icons.search)
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.bottomNavTap(index);
            },
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items:const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),label: 'Products'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),label: 'Favorites'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),label: 'Settings'
              ),
            ],
          ),
        );
      },
    );
  }
}
