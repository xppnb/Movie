import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  ///实际的绘画发生在这里
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    var paint = Paint();
    paint.color = Colors.grey;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;

    // var startPoint = Offset(0, size.height / 2);
    // var controlPoint1 = Offset(size.width / 4, size.height/4);
    // var controlPoint2 = Offset(3 * size.width / 4, size.height/4);
    // var endPoint = Offset(size.width, size.height / 2);
    // var path = Path();
    // path.moveTo(startPoint.dx, startPoint.dy);
    // path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
    //     controlPoint2.dy, endPoint.dx, endPoint.dy);
    // canvas.drawPath(path,paint);


    var startPoint = Offset(-50, 100 / 2);
    var controlPoint1 = Offset(100 / 4, 100/4);
    var controlPoint2 = Offset(3 * 100 / 4, 100/4);
    var endPoint = Offset(150, 100 / 2);
    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);
    canvas.drawPath(path,paint);



    // ///创建画笔
    // var paint = Paint();
    // ///设置画笔的颜色
    // paint.color = Colors.blue;
    // ///创建路径
    // var path = Path();
    //
    // ///A点 设置初始绘制点
    // path.moveTo(0, 55);
    // /// 绘制到 B点（100，0）
    // path.cubicTo(0, 25, 48, 0, 100, 0);
    // /// 绘制到 C点（214, 55）
    // path.cubicTo(166, 0, 214, 25, 214, 55);
    // ///绘制 Path
    // canvas.drawPath(path, paint);
  }

  ///这样Flutter就知道它必须调用paint方法来重绘你的绘画。
  ///否则，在此处返回false表示您不需要重绘
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
