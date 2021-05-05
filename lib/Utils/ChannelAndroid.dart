




import 'package:flutter/services.dart';


const methodChannel = MethodChannel("android");
Future ChannelAndroid(String method,{String argument}) async{
  if(argument == null){
    return methodChannel.invokeMethod(method);
  }else{
    return methodChannel.invokeMethod(method,argument);
  }
}