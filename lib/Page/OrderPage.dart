import 'package:china_model_b/DataBean/OrderBean/OrderData.dart';
import 'package:china_model_b/Utils/ChannelAndroid.dart';
import 'package:china_model_b/Utils/Constart.dart';
import 'package:china_model_b/Utils/TimeUtils.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  OrderData orderData;

  OrderPage({this.orderData});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrderPageBody(
        orderData: widget.orderData,
      ),
    );
  }
}

class OrderPageBody extends StatefulWidget {
  OrderData orderData;

  OrderPageBody({this.orderData});

  @override
  _OrderPageBodyState createState() => _OrderPageBodyState();
}

class _OrderPageBodyState extends State<OrderPageBody> {
  OrderData orderData;
  bool f;
  double totalNum;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChannelAndroid("permission");
    orderData = widget.orderData;
    f = false;
    totalNum = orderData.priceNum;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25, left: 15, right: 15),
      child: Column(
        children: [
          topIntroduction(),
          call(),
          buyTicketKnow(),
          confirmPayment(),
        ],
      ),
    );
  }

  ///顶部介绍
  Widget topIntroduction() {
    return Container(
      width: 500,
      height: 200,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              orderData.homeData["img"],
              fit: BoxFit.contain,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderData.homeData["name"],
                  style: orderMovieNameStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    TimeUtils.determineTime(orderData.movieTime)
                        ? Text("今天")
                        : Container(),
                    Text(orderData.movieTime.toString()),
                    SizedBox(
                      width: 5,
                    ),
                    Text(orderData.movieData["startTime"] +
                        "~" +
                        orderData.movieData["lastTime"]),
                    SizedBox(
                      width: 5,
                    ),
                    Text(orderData.movieData["visual"])
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(orderData.movieData["office"]),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 180,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 5,
                        children: ((orderData.seatNumber) as List).map((e) {
                          return Text(e.row.toString() +
                              "排" +
                              e.column.toString() +
                              "座");
                        }).toList(),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                ((orderData.movieData["visual"]) as String).contains("3D")
                    ? Container(
                        width: 230,
                        height: 80,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "是否购买眼镜",
                              style: orderMovieNameStyle2,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  child: Checkbox(
                                      value: f,
                                      onChanged: (isCheck) {
                                        setState(() {
                                          print(isCheck);
                                          f = isCheck;
                                          if (f) {
                                            totalNum += 30;
                                          } else {
                                            totalNum -= 30;
                                          }
                                          // print(totalNum.toStringAsFixed(1));
                                        });
                                      }),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "¥30",
                                  style: orderMovieNameStyle3,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          )
        ],
      ),
    );
  }

  ///拨打电话
  Widget call() {
    return InkWell(
      onTap: () {
        ///调用原生打电话
        print("123");
        ChannelAndroid("call");
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        width: 500,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 1),
        ),
        alignment: Alignment.center,
        child: Text(
          "拨打客服xpp",
          style: orderMovieNameStyle4,
        ),
      ),
    );
  }

  ///购票需知
  Widget buyTicketKnow() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        width: 500,
        height: 250,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "购票须知:",
              style: orderMovieNameStyle4,
            ),
            SizedBox(
              height: 5,
            ),
            Text(widget.orderData.homeData["description"]),
          ],
        ));
  }

  ///确认支付
  Widget confirmPayment() {
    return Card(
      child: Container(
        width: 500,
        height: 75,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "¥" + totalNum.toStringAsFixed(2),
              style: orderMovieNameStyle5,
            ),
            SizedBox(
              width: 5,
            ),
            Container(
                width: 150,
                height: 60,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: () {
                    ChannelAndroid("finger");
                  },
                  child: Text(
                    "立即付款",
                    style: orderMovieNameStyle6,
                  ),
                  color: Colors.red.withOpacity(0.9),
                ))
          ],
        ),
      ),
    );
  }
}
