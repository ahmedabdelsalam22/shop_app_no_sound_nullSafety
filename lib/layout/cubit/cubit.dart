
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context)=>BlocProvider.of(context);

  // bottom nav bar
  int currentIndex =0;

  List<Widget> screens=[
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
     SettingsScreen()
  ];

  void bottomNavTap(int index)
  {
    currentIndex = index;
    emit(ShopBottomNavTapState());
  }

  // get home data with api

  HomeModel homeModel;
  Map<int,bool> favorites ={};

  void getHomeData()
  {
    emit(ShopHomeDataLoadingState());

    DioHelper.getData(
        url: HOME,
      token: token
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //print(homeModel.data.banners[0].image);
      //print(homeModel.status);


      homeModel.data.products.forEach((element)
      {
        favorites.addAll({
          element.id : element.inFavorites
        });
      });
      print(favorites.toString());

      emit(ShopHomeDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopHomeDataErrorState());
    });
  }


  // get categories data with api


  CategoriesModel categoriesModel;

  void getCategoriesData()
  {
    DioHelper.getData(
        url: CATEGOTRIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
     // print(categoriesModel.data.data[0].image);
      emit(ShopCategoriesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopCategoriesErrorState());
    });
  }

//change favorites events

  ChangeFavoriteModel changeFavoriteModel;

  void changeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId];
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id':productId
        },
      token:token
    ).then((value) {

      changeFavoriteModel =ChangeFavoriteModel.fromJson(value.data);
      print(value.data);

      if(!changeFavoriteModel.status)
      {
        favorites[productId] = !favorites[productId];
      }else{
        getFavoritesData();
      }

     emit(ShopFavoritesSuccessState(changeFavoriteModel));
    }).catchError((error){

      favorites[productId] = !favorites[productId];

      emit(ShopFavoritesErrorState());
    });
  }


  // get favorites
  FavoritesModel favoritesModel;

  void getFavoritesData()
  {
    emit(ShopGetFavoritesLoadingState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
      lang: 'en'
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(favoritesModel.data);

      emit(ShopGetFavoritesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopGetFavoritesErrorState());
    });
  }


  //get profile

  ShopLoginModel userModel;

  void getUserData()
  {

    emit(ShopGetUserDataLoadingState());

    DioHelper.getData(
        url: PROFILE,
        token: token,
        lang: 'en'
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel.data.name);

      emit(ShopGetUserDataSuccessState(userModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopGetUserDataErrorState());
    });
  }



  void updateUserData({
  @required String name,
    @required String email,
    @required String phone,


  })
  {

    emit(ShopGetUpdateUserLoadingState());

    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data: {
          'name':name,
          'email':email,
          'phone':phone,
        }
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel.data.name);

      emit(ShopGetUpdateUserSuccessState(userModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopGetUpdateUserErrorState());
    });
  }



}