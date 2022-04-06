
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

void signOut(context)
{
  CacheHelper.removeData(
      key: 'token'
  ).then((value) {
    if(value){
      navigateToAndFinish(context,ShopLoginScreen());
    }
  });
}

String token = '';

// 8ZqDJOVuTgxfax4MOa4WWTBrSRa3WIisNAMkwC5QjUxfE5Y37KVgsdqxfo5EoYx39YqIAK

