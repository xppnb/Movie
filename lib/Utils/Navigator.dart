import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


///跳转界面
class NavigatorUtils{
    static push(BuildContext context,Widget page) async{
        final result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>page));
        return result;
    }
}