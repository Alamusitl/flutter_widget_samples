import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_widget_samples/util/ui_util.dart';

const List kDrawType = [
  '点',
  '线',
  '路径',
  '圆',
  '椭圆',
  '弧线',
  '圆角矩形',
  '贝塞尔曲线',
  '弧线进度条',
];

abstract class MyPainter extends CustomPainter {
  final Paint pen;

  MyPainter(this.pen);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class CustomPaintPage extends StatefulWidget {
  @override
  _CustomPaintPageState createState() => _CustomPaintPageState();
}

class _CustomPaintPageState extends State<CustomPaintPage> {
  String drawType = kDrawType.first;

  PointMode pointMode = PointMode.polygon;

  Paint paint;

  @override
  initState() {
    super.initState();
    paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3;
  }

  void updatePaint(var val) {
    paint = Paint()
      ..color = paint.color
      ..strokeWidth = paint.strokeWidth
      ..style = val;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UiUtil.getDeviceWidth(context),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Wrap(
            spacing: 16.0,
            children: kDrawType
                .map((key) => ChoiceChip(
                      label: Text(key),
                      selected: drawType == key,
                      onSelected: (val) {
                        drawType = val ? key : '';
                        setState(() {});
                      },
                    ))
                .toList(),
          ),
          CustomCanvas(
            type: drawType,
            pointMode: pointMode,
            pen: paint,
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: Text('Fill'),
                  value: PaintingStyle.fill,
                  groupValue: paint.style,
                  onChanged: updatePaint,
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: Text('Stroke'),
                  value: PaintingStyle.stroke,
                  groupValue: paint.style,
                  onChanged: updatePaint,
                ),
              ),
            ],
          ),
          Offstage(
            offstage: drawType != '点',
            child: Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: Text('点'),
                    value: PointMode.points,
                    groupValue: pointMode,
                    onChanged: (val) {
                      setState(() {
                        pointMode = val;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text('线'),
                    value: PointMode.lines,
                    groupValue: pointMode,
                    onChanged: (val) {
                      setState(() {
                        pointMode = val;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text('多边形'),
                    value: PointMode.polygon,
                    groupValue: pointMode,
                    onChanged: (val) {
                      setState(() {
                        pointMode = val;
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomCanvas extends StatelessWidget {
  CustomCanvas({
    Key key,
    this.type,
    this.pointMode = PointMode.polygon,
    this.pen,
  })  : painter = initialPainter(type, pen, pointMode: pointMode),
        super(key: key);

  final String type;

  final PointMode pointMode;

  final Paint pen;

  final CustomPainter painter;

  static CustomPainter initialPainter(String type, Paint pen, {PointMode pointMode}) {
    switch (type) {
      case '点':
        return _PointPainter(pointMode, pen);
      case '线':
        return _LinePainter(pen);
      case '路径':
        return _PathPainter(pen);
      case '圆':
        return _CirclePainter(pen);
      case '椭圆':
        return _OvalPainter(pen);
      case '弧线':
        return _ArcPainter(pen);
      case '圆角矩形':
        return _RRectPainter(pen);
      case '贝塞尔曲线':
        return _BezierPainter(pen);
      case '弧线进度条':
        return _ArcProgressPainter(pen);
      default:
        return _PointPainter(pointMode, pen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UiUtil.getDeviceWidth(context),
      decoration: BoxDecoration(border: Border.all()),
      padding: const EdgeInsets.all(30.0),
      child: CustomPaint(
        size: Size(0, 180),
        painter: painter,
      ),
    );
  }
}

class _PointPainter extends MyPainter {
  final PointMode pointMode;

  _PointPainter(this.pointMode, Paint pen) : super(pen);

  @override
  void paint(Canvas canvas, Size size) {
    var points = [
      Offset(0.0, 0.0),
      Offset(size.width / 2, size.height / 2),
      Offset(size.width, size.height / 2)
    ];
    canvas.drawPoints(pointMode, points, pen);
  }
}

class _LinePainter extends MyPainter {
  _LinePainter(Paint pen) : super(pen);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(0.0, 0.0), Offset(size.width, size.height), pen);
  }
}

class _PathPainter extends MyPainter {
  _PathPainter(Paint pen) : super(pen);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height / 2)
      ..close();
    canvas.drawPath(path, pen);
  }
}

class _CirclePainter extends MyPainter {
  _CirclePainter(Paint pen) : super(pen);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 30, pen);
  }
}

class _OvalPainter extends MyPainter {
  _OvalPainter(Paint pen) : super(pen);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(Rect.fromLTRB(0, 0, size.width, size.height), pen);
  }
}

class _ArcPainter extends MyPainter {
  _ArcPainter(Paint pen) : super(pen);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(Rect.fromLTRB(0, 0, size.width / 2, size.height / 2), 0, pi / 2, true, pen);
  }
}

class _RRectPainter extends MyPainter {
  _RRectPainter(Paint pen) : super(pen);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(RRect.fromLTRBR(0, 0, size.width, size.height, Radius.circular(10.0)), pen);
  }
}

class _BezierPainter extends MyPainter {
  _BezierPainter(Paint pen) : super(pen);

  @override
  void paint(Canvas canvas, Size size) {
    // 波浪线
    Path path = Path();
    path.lineTo(0, 0); // 第一点
    path.lineTo(0, size.height - 40.0); // 第二点
    var firstControlPoint = Offset(size.width / 4, size.height); // 第一曲线控制点
    var firstEndPoint = Offset(size.width / 2.25, size.height - 40.0); // 第一曲线结束点
    path.quadraticBezierTo(
      // 形成曲线
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    var secondControlPoint = Offset(size.width / 4 * 3, size.height - 90); // 第二曲线控制点
    var secondEndPoint = Offset(size.width, size.height - 40); // 第二曲线结束点
    path.quadraticBezierTo(
      // 形成曲线
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );
    path.lineTo(size.width, size.height - 40); // 第三点
    path.lineTo(size.width, 0); // 第四点
    path.close();

    canvas.drawPath(path, pen);
  }
}

class _ArcProgressPainter extends MyPainter {
  double startAngle = pi * 8 / 9;
  double endAngle = -(pi * 7 / 9);

  _ArcProgressPainter(Paint pen) : super(pen);

  @override
  void paint(Canvas canvas, Size size) {
    Paint bgPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    Rect rect =
        Rect.fromCircle(center: Offset(size.width / 2, size.height / 4), radius: size.width / 3);
    canvas.drawArc(rect, startAngle, endAngle, false, bgPaint);

    Paint paint = Paint()
      ..color = Colors.pinkAccent
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;

    canvas.drawArc(rect, startAngle, endAngle * 0.7, false, paint);
  }
}
