import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/states.dart';
import 'package:shop_app/shared/components/components.dart';

import 'cubit.dart';

class SearchScreen extends StatelessWidget {

  var formKey =GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){

          var cubit =SearchCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                      defaultFormField(
                        onSubmit: (text){
                          cubit.getSearch(text);
                        },
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String value){
                          if(value.isEmpty){
                            return 'Please Enter Text';
                          }return null;
                        },
                        labelText: 'Search',
                        prefix: Icons.search,
                      ),
                   const SizedBox(height: 15),
                   if(state is SearchLoadingStates)
                   const LinearProgressIndicator(),
                    const SizedBox(height: 10),
                    if(state is SearchSuccessStates)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context,index)=>buildListProduct(SearchCubit.get(context).searchModel.data.data[index],context,isOldPrice: false),
                          separatorBuilder: (context,index)=> separatedDivider(),
                          itemCount: SearchCubit.get(context).searchModel.data.data.length
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
