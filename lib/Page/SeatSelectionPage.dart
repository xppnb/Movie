import 'package:china_model_b/DataBean/OrderBean/OrderData.dart';
import 'package:china_model_b/DataBean/SeatBean/SeatData.dart';
import 'package:china_model_b/Page/OrderPage.dart';
import 'package:china_model_b/Utils/ChannelAndroid.dart';
import 'package:china_model_b/Utils/Constart.dart';
import 'package:china_model_b/Utils/TimeUtils.dart';
import 'package:china_model_b/Utils/MyPainter.dart';
import 'package:china_model_b/Utils/NavigatorUtils.dart';
import 'package:china_model_b/Utils/NewInteractiveViewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeatSelectionPage extends StatefulWidget {
  SeatData seatData;

  SeatSelectionPage({this.seatData});

  @override
  _SeatSelectionPageState createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SeatSelectionBody(
        seatData: widget.seatData,
      ),
    );
  }
}

class SeatSelectionBody extends StatefulWidget {
  SeatData seatData;

  SeatSelectionBody({this.seatData});

  @override
  _SeatSelectionBodyState createState() => _SeatSelectionBodyState();
}

class _SeatSelectionBodyState extends State<SeatSelectionBody> {
  List<int> seatNumber = [];
  List<List<BoardType>> boardTypeList = [];
  GlobalKey<NewInteractiveViewerState> newInteractiveViewerKey;
  int row;
  int column;
  List<Point> seatNumberList = [];
  int num = 0;
  int tempNum = 0;

  double priceNum = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seatNumber = [1, 2, 3, 4, 5, 6, 7];
    for (int i = 0; i < 7; i++) {
      boardTypeList.add(List.generate(
          5, (index) => BoardType(isSelect: false, row: i, column: index)));
    }
    newInteractiveViewerKey = new GlobalKey<NewInteractiveViewerState>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        screen(),
        chooseSeatWidget(),
        stateGrid(),
        SizedBox(
          height: 10,
        ),
        movieDetails(),
        okButton(),
      ],
    ));
  }

  ///电影屏幕
  Widget screen() {
    return Container(
      width: 100,
      child: CustomPaint(
        painter: MyPainter(),
      ),
    );
  }

  ///选座
  Widget chooseSeatWidget() {
    Point point = new Point();

    List<Row> rowList = [];
    for (int i = 0; i < 7; i++) {
      List<InkWell> inkWellList = [];
      for (int j = 0; j < 5; j++) {
        inkWellList.add(InkWell(
          onTap: () {
            setState(() {
              if (seatNumberList.length == 5) {
                num = 0;
                tempNum = 0;
                if (boardTypeList[i][j].isSelect) {
                  seatNumberList.forEach((element) {
                    if (element.row == i + 1 && element.column == j + 1) {
                      num = tempNum;
                    }
                    tempNum++;
                  });
                  seatNumberList.removeAt(num);
                  priceNum -= double.parse(widget.seatData.movieData["price"]);
                  print(priceNum);
                  if (seatNumberList.length < 5) {
                    boardTypeList[i][j].isSelect =
                        !boardTypeList[i][j].isSelect;
                  }
                } else {
                  ///调用原生弹出toast
                  ChannelAndroid("movieToast");
                  print("一次最多可以购买五张票");
                }
              } else {
                boardTypeList[i][j].isSelect = !boardTypeList[i][j].isSelect;
                if (boardTypeList[i][j].isSelect) {
                  point.row = ++i;
                  point.column = ++j;
                  seatNumberList.add(point);
                  priceNum += double.parse(
                      double.parse(widget.seatData.movieData["price"])
                          .toStringAsFixed(1));
                  print("num是" + num.toString());
                  print(priceNum);
                } else {
                  num = 0;
                  tempNum = 0;
                  seatNumberList.forEach((element) {
                    if (element.row == i + 1 && element.column == j + 1) {
                      num = tempNum;
                    }
                    tempNum++;
                  });
                  print("num是" + num.toString());
                  seatNumberList.removeAt(num);
                  priceNum -= double.parse(
                      double.parse(widget.seatData.movieData["price"])
                          .toStringAsFixed(1));
                  print(priceNum);
                }
              }

              print(seatNumberList.toString());
            });
          },
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              color: boardTypeList[i][j].isSelect ? Colors.red : Colors.white,
            ),
            child: Center(
              child: boardTypeList[i][j].isSelect ? Icon(Icons.done) : null,
            ),
          ),
        ));
      }
      rowList.add(Row(
        children: inkWellList,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ));
    }

    return Center(
      child: Container(
        width: 500,
        height: 440,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NewInteractiveViewer(
                key: newInteractiveViewerKey,
                boundaryMargin: EdgeInsets.all(50),
                panEnabled: false,
                scaleEnabled: true,
                maxScale: 1.2,
                minScale: 0.1,
                child: Container(
                  height: 300,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: seatNumber.map((e) {
                      return Text(e.toString());
                    }).toList(),
                  ),
                )),
            InteractiveViewer(
              // key: fromViewKey,
              maxScale: 1.2,
              minScale: 0.1,
              boundaryMargin: EdgeInsets.all(40),
              panEnabled: true,
              onInteractionStart: (ScaleStartDetails details) {
                print('onInteractionStart----' + details.toString());
                newInteractiveViewerKey.currentState.onScaleStart(details);
              },
              onInteractionUpdate: (ScaleUpdateDetails details) {
                print('onInteractionUpdate----' + details.toString());
                newInteractiveViewerKey.currentState.onScaleUpdate(details);
              },

              onInteractionEnd: (ScaleEndDetails details) {
                print('onInteractionEnd----' + details.toString());
                newInteractiveViewerKey.currentState.onScaleEnd(details);
              },
              child: Container(
                width: 300,
                height: 300,
                // decoration: BoxDecoration(
                //   color: Colors.grey,
                // ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: rowList,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///状态(可选，已售，不可售)
  Widget stateGrid() {
    return Container(
      width: 500,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    print("123");
                  });
                },
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                ),
              ),
              Text("可选"),
            ],
          ),
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  color: Colors.red,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.done,
                  size: 15,
                ),
              ),
              Text("已售"),
            ],
          ),
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                color: Colors.black,
              ),
              Text("不可选"),
            ],
          ),
        ],
      ),
    );
  }

  ///电影详情界面
  Widget movieDetails() {
    // var dateTime = DateTime.now();
    // print(dateTime.toString());
    return Container(
      padding: EdgeInsets.all(10),
      width: 400,
      height: 150,
      decoration: BoxDecoration(border: Border.all(width: 1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.seatData.homeData["name"]}",
            style: movieSeatNameStyle1,
          ),
          Row(
            children: [
              Text(
                TimeUtils.determineTime(widget.seatData.movieTime) ? "今天" : "",
                style: movieStyle4,
              ),
              TimeUtils.determineTime(
                widget.seatData.movieTime,
              )
                  ? SizedBox(
                      width: 5,
                    )
                  : Container(),
              Text(widget.seatData.movieTime.toString()),
              SizedBox(
                width: 5,
              ),
              Text(widget.seatData.movieData["startTime"] +
                  "-" +
                  widget.seatData.movieData["lastTime"]),
              SizedBox(
                width: 5,
              ),
              Text(widget.seatData.movieData["visual"]),
            ],
          ),
          Row(
            children: seatNumberList.map((e) {
              return Card(
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: 67,
                  height: 50,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(e.row.toString() +
                              "排" +
                              e.column.toString() +
                              "座"),
                          Text(
                            "¥" + widget.seatData.movieData["price"].toString(),
                            style: movieStyle4,
                          ),
                        ],
                      ),
                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.clear,
                            size: 13,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            seatNumberList.remove(e);
                            boardTypeList[e.row - 1][e.column - 1].isSelect =
                                false;
                            priceNum -= double.parse(
                                double.parse(widget.seatData.movieData["price"])
                                    .toStringAsFixed(1));
                            print(priceNum);
                          });
                        },
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  ///确定按钮
  Widget okButton() {
    return Container(
        margin: EdgeInsets.only(top: 5),
        width: double.infinity,
        height: 50,
        child: RaisedButton(
          onPressed: seatNumberList.length == 0
              ? null
              : () {
                  NavigatorUtils.push(
                      context,
                      OrderPage(
                        orderData: OrderData(
                            widget.seatData.homeData,
                            widget.seatData.movieTime,
                            widget.seatData.movieData,
                            seatNumberList,
                            priceNum),
                      ));
                },
          color: Colors.red.withOpacity(1),
          child: seatNumberList.length <= 0
              ? Text(
                  "请先选座",
                  style: movieSeatNameStyle2,
                )
              : Text(
                  "¥${priceNum.toStringAsFixed(2)}" + " " + "确认选座",
                  style: movieSeatNameStyle3,
                ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ));
  }
}

class BoardType {
  bool isSelect = false;
  int column;
  int row;

  BoardType({this.isSelect, this.column, this.row});
}

class Point {
  int _row;
  int _column;

  int get row => _row;

  set row(int value) {
    _row = value;
  }

  @override
  String toString() {
    return 'Point{row: $row, column: $column}';
  }

  int get column => _column;

  set column(int value) {
    _column = value;
  }
}
