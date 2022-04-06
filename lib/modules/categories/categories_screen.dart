import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
      builder: (context,state){

          var cubit = ShopCubit.get(context);

          return ListView.separated(
              itemBuilder: (context,index)=>buildCatItem(cubit.categoriesModel.data.data[index]),
              separatorBuilder: (context,index)=> separatedDivider(),
              itemCount: cubit.categoriesModel.data.data.length
          );
      },
    );
  }

  Widget buildCatItem(DataModel dataModel)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:  [
        Image(
          image: NetworkImage(dataModel.image),
          height:80,width:80 ,fit: BoxFit.cover,
        ),
        const SizedBox(width: 20,),
        Text(
          dataModel.name,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
        ),
        const Spacer(),
         Icon(
             Icons.arrow_forward_ios
         )
      ],
    ),
  );

}
