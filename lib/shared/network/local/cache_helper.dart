import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static SharedPreferences sharedPreferences;

  // ignore: missing_return
  static Future<Response> init()
  async{
    sharedPreferences =await SharedPreferences.getInstance();
  }


  // put data
  static Future<bool> putBoolean({
  @required String key,
    @required bool value
})
  async{
   return await sharedPreferences.setBool(key, value);
  }


  // get data
  static dynamic getData({@required String key})
  {
   return sharedPreferences.get(key);
  }

  // another method to get data
  static bool getBoolean({@required String key})
  {
    return sharedPreferences.getBool(key);
  }


  // save data
  static Future<bool> saveData({
    @required String key,
    @required dynamic value
  })async{
    if(value is String) return await sharedPreferences.setString(key, value);
    if(value is int) return await sharedPreferences.setInt(key, value);
    if(value is bool) return await sharedPreferences.setBool(key, value);

    return await sharedPreferences.setDouble(key, value);
  }


  static Future<bool> removeData({@required key})
  async{
   return await sharedPreferences.remove(key);
  }

}
