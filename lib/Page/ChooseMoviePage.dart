import 'dart:async';

//import 'dart:html';
import 'package:china_model_b/DataBean/SeatBean/SeatData.dart';
import 'package:china_model_b/HttpService/HttpService.dart';
import 'package:china_model_b/Page/SeatSelectionPage.dart';
import 'package:china_model_b/Utils/ChannelAndroid.dart';
import 'package:china_model_b/Utils/Constart.dart';
import 'package:china_model_b/Utils/NavigatorUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HttpService httpService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    httpService = new HttpService();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.green,
          ));
        } else {
          // ignore: unrelated_type_equality_checks
          if (snap.hasError) {
            return Center(
              child: Text("刷新失败，请稍后再试"),
            );
          } else {
            List hasData = snap.data;
            return HomeWidget(
              listData: hasData,
            );
          }
        }
      },
      future: httpService.getTopService(),
    );
  }
}

///全局
class HomeWidget extends StatefulWidget {
  List listData;

  HomeWidget({this.listData});

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int currentIndex = 0;
  var homeData;
  var plot;
  TabController tabController;

  ///电影日期
  String movieTime;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeData = widget.listData[currentIndex];
    plot = homeData["type"].toString().replaceAll("/", "|");
    tabController = new TabController(
        length: homeData["shop"].length, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        Container(
          width: 100,
          height: 150,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return cover(index);
            },
            itemCount: widget.listData.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
          ),
        ),
        Container(
          child: introduce(),
        ),
        showTime(),
      ],
    );
  }

  ///封面
  Widget cover(int index) {
    return Container(
        padding: EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            setState(() {
              currentIndex = index;
              print(currentIndex);
              homeData = widget.listData[currentIndex];
              if (homeData["type"].toString().contains("/")) {
                plot = homeData["type"].toString().replaceAll("/", "|");
              }
              tabController = TabController(
                  length: homeData["shop"].length,
                  vsync: this,
                  initialIndex: 1);
              tabController.animateTo(0);
            });
          },
          onLongPress: () {
            print("123");
            ChannelAndroid("movieTest");
          },
          child: Image.network(
            widget.listData[index]["img"],
            fit: BoxFit.contain,
          ),
        ));
  }

  ///电影介绍
  Widget introduce() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(homeData["name"]),
              SizedBox(
                width: 10,
              ),
              Text(
                homeData["rating"] + "分",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${(homeData["duration"] / 60).toInt()}分钟|",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              Text(plot, style: TextStyle(color: Colors.grey, fontSize: 11))
            ],
          ),
          Container(
            width: 500,
            height: 20,
            alignment: Alignment.center,
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: (homeData["actor"] as List).map((e) {
                return Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    e.toString(),
                    style: movieStyle,
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  ///购票部分
  Widget showTime() {
    var shopData = homeData["shop"] as List;
    // print(homeData["country"]);
    // print(homeData["shop"][0]["time"][0]);
    ///赋值第一次电影日期
    movieTime = shopData[0]["date"].toString();
    return Container(
        child: Column(
      children: [
        TabBar(
          tabs: shopData.map((e) {
            return Tab(
              text: e["date"].toString(),
            );
          }).toList(),
          controller: tabController,
          indicatorColor: Colors.red,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
          physics: BouncingScrollPhysics(),
          onTap: (index){
            movieTime = shopData[index]["date"];
          },
        ),
        Container(
          width: 500,
          height: 300,
          child: TabBarView(
            children: shopData.map((e) {
              return buyTicket(e);
            }).toList(),
            controller: tabController,
            physics: BouncingScrollPhysics(),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          child: Text(
            "xpp-movie",
            style: movieStyle6,
          ),
        )
      ],
    ));
  }

  ///购票部分
  Widget buyTicket(Map e) {
    ///电影时间
    List movieTimeList = e["time"];
    return Container(
        width: 500,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return buyTicketListView(index, movieTimeList[index]);
          },
          itemCount: movieTimeList.length,
          physics: BouncingScrollPhysics(),
        ));
  }

  Widget buyTicketListView(
    int index,
    Map movieData,
  ) {
    return Card(
      elevation: 0.2,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movieData["startTime"].toString()),
                SizedBox(
                  height: 5,
                ),
                Text(movieData["lastTime"].toString() + "散场",
                    style: movieStyle),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              width: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieData["visual"],
                    style: movieStyle2,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    movieData["office"],
                    style: movieStyle,
                  ),
                ],
              ),
            ),
            Container(
                width: 100,
                margin: EdgeInsets.only(left: 150),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: Text(
                        "¥${movieData["price"]}",
                        style: movieStyle4,
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 25,
                      child: InkWell(
                        onTap: () {
                          //NavigatorUtils.push(context, SeatSelectionPage());
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return SeatSelectionPage(seatData: SeatData(homeData,movieTime,movieData),);
                          }));
                        },
                        child: Text(
                          "购票",
                          style: movieStyle5,
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
