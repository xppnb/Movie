import 'dart:convert';
import 'dart:io';

import 'package:china_model_b/Utils/Constart.dart';


class HttpService {
  Future<HttpClientRequest> getHttpClient(String urlName) async {
    HttpClient httpClient = new HttpClient();
    return httpClient.postUrl(Uri.parse(servicePath[urlName])); //servicePath[urlName]
    }

  Future getTopService() async {
    try {
      try {
        return getHttpClient("top").then((httpClientRequest) async {
          httpClientRequest.headers.contentType = ContentType("application", "x-www-form-urlencoded");
          httpClientRequest
              .write("appKey=$appKey");
          var httpClientResponse = await httpClientRequest.close();
          if (httpClientResponse.statusCode == 200) {
            var s = await httpClientResponse.transform(Utf8Decoder()).join();
            var data = jsonDecode(s.toString())["data"];
            return data;
          }
        });
      } catch (e) {
        print("数据异常");
      }
    } catch (e) {
      print("后端数据异常");
    }
  }
}
