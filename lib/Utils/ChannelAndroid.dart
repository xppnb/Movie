





import 'package:china_model_b/Utils/Constart.dart';

Future ChannelAndroid(String method,{String argument}) async{
  if(argument == null){
    return methodChannel.invokeMethod(method);
  }else{
    return methodChannel.invokeMethod(method,argument);
  }
}