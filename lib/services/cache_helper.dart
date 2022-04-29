
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CacheHelper {
  static SharedPreferences sp;

  static init()async{
    sp= await SharedPreferences.getInstance();
  }

  Future<bool> saveString({@required String key,@required String value})async{
    return await sp.setString(key, value);
  }

  Future<bool> saveBoolean({@required String key,@required bool value})async{
    return await sp.setBool(key, value);
  }

  Future<bool> saveInteger({@required String key,@required int value})async{
    return await sp.setInt(key, value);
  }

  Future<bool> saveDouble({@required String key,@required double value})async{
    return await sp.setDouble(key, value);
  }

  static dynamic getData({@required String key}){
    return sp.get(key);
  }
}