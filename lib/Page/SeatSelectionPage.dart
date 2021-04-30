import 'package:flutter/material.dart';


class SeatSelectionPage extends StatefulWidget {
  @override
  _SeatSelectionPageState createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SeatSelectionBody(),
    );
  }
}

class SeatSelectionBody extends StatefulWidget {
  @override
  _SeatSelectionBodyState createState() => _SeatSelectionBodyState();
}

class _SeatSelectionBodyState extends State<SeatSelectionBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("123"),
      ),
    );
  }
}
