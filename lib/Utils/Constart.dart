

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const serviceUrl = "https://www.fastmock.site/mock/bed5971954e3e55d23d4b051a028389d/movie";

const servicePath = {
  "top" : serviceUrl + '/top250',
};

const appKey = "4d60bc67-c6b8-42a0-822e-0c4c621423ce";




///电影散场
const movieStyle = TextStyle(color: Colors.grey,fontSize: 10);
const movieStyle2 = TextStyle(color: Colors.black87,fontSize: 10);
const movieStyle3 = TextStyle(color: Colors.black,fontSize: 20);
TextStyle movieStyle4 = TextStyle(color: Colors.red[500]);
TextStyle movieStyle5 = TextStyle(color: Colors.red[800],fontSize: 11);
const movieStyle6 = TextStyle(color: Colors.grey,fontSize: 20);



///电影选座
const movieSeatNameStyle1 = TextStyle(fontWeight: FontWeight.w800,fontSize: 15);
const movieSeatNameStyle2 = TextStyle(color: Colors.black);
const movieSeatNameStyle3 = TextStyle(color: Colors.white,fontSize: 18);


///订单页面
const orderMovieNameStyle = TextStyle(fontWeight: FontWeight.w800,fontSize: 20);
const orderMovieNameStyle2 = TextStyle(fontWeight: FontWeight.w800,fontSize: 15);
const orderMovieNameStyle3 = TextStyle(color: Colors.red,fontSize: 15);
const orderMovieNameStyle4 = TextStyle(fontWeight: FontWeight.w800,fontSize: 20);
const orderMovieNameStyle5 = TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.w700);
const orderMovieNameStyle6 = TextStyle(color: Colors.white,fontSize: 18);