import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){

        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: state is! ShopGetFavoritesLoadingState,
          builder: (BuildContext context) {
            return ListView.separated(
                itemBuilder: (context,index)=>buildListProduct(cubit.favoritesModel.data.data[index].product,context),
                separatorBuilder: (context,index)=> separatedDivider(),
                itemCount: cubit.favoritesModel.data.data.length
            );
          },
          fallback: (context)=>const Center(child: CircularProgressIndicator()),

        );
      },
    );
  }




}






