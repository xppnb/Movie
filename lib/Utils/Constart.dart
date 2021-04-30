

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const serviceUrl = "https://www.fastmock.site/mock/bed5971954e3e55d23d4b051a028389d/movie";

const servicePath = {
  "top" : serviceUrl + '/top250',
};

const appKey = "4d60bc67-c6b8-42a0-822e-0c4c621423ce";

const methodChannel = MethodChannel("android");


///电影散场
const movieStyle = TextStyle(color: Colors.grey,fontSize: 10);
const movieStyle2 = TextStyle(color: Colors.black87,fontSize: 10);
const movieStyle3 = TextStyle(color: Colors.black,fontSize: 20);
TextStyle movieStyle4 = TextStyle(color: Colors.red[500]);
TextStyle movieStyle5 = TextStyle(color: Colors.red[800],fontSize: 11);
const movieStyle6 = TextStyle(color: Colors.grey,fontSize: 20);