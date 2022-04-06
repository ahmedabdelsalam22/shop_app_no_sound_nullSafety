import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates{}

class ShopBottomNavTapState extends ShopStates{}

class ShopHomeDataLoadingState extends ShopStates{}

class ShopHomeDataSuccessState extends ShopStates{}

class ShopHomeDataErrorState extends ShopStates{}

class ShopCategoriesSuccessState extends ShopStates{}

class ShopCategoriesErrorState extends ShopStates{}

class ShopFavoritesSuccessState extends ShopStates{
  final ChangeFavoriteModel model;

  ShopFavoritesSuccessState(this.model);
}

class ShopChangeFavoritesState extends ShopStates{}

class ShopFavoritesErrorState extends ShopStates{}

class ShopGetFavoritesSuccessState extends ShopStates{}

class ShopGetFavoritesLoadingState extends ShopStates{}

class ShopGetFavoritesErrorState extends ShopStates{}


class ShopGetUserDataSuccessState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopGetUserDataSuccessState(this.loginModel);

}

class ShopGetUserDataLoadingState extends ShopStates{}

class ShopGetUserDataErrorState extends ShopStates{}


class ShopGetUpdateUserSuccessState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopGetUpdateUserSuccessState(this.loginModel);

}

class ShopGetUpdateUserLoadingState extends ShopStates{}

class ShopGetUpdateUserErrorState extends ShopStates{}