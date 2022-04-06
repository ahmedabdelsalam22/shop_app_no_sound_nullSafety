import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/states.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(InitialSearchStates());

  static SearchCubit get(context)=>BlocProvider.of(context);


  SearchModel searchModel;

  void getSearch(String text)
  {
    emit(SearchLoadingStates());

    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {'text':text}
    ).then((value) {
       searchModel =SearchModel.fromJson(value.data);
      emit(SearchSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorStates());
    });
  }

}