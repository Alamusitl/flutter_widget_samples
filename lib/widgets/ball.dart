import 'package:flutter/material.dart';

class Ball {
  Ball({
    this.id,
    this.accelerationX = 0.0,
    this.accelerationY = 0.0,
    this.velocityX,
    this.velocityY,
    this.x,
    this.y,
    this.radius,
    this.color,
  });

  /// Ball id
  final int id;

  /// 加速度X
  double accelerationX;

  /// 加速度Y
  double accelerationY;

  /// 速度X
  double velocityX;

  /// 速度Y
  double velocityY;

  /// 位置X
  double x;

  /// 位置Y
  double y;

  /// Ball radius
  double radius;

  /// Ball color
  Color color;
}

class RunBall extends CustomPainter {
  RunBall({
    this.ball,
    this.area,
    this.bgColor,
  })  : _ballPaint = Paint()..color = ball.color,
        _bgPaint = Paint()..color = bgColor;

  final Color bgColor;

  Ball ball;
  Rect area;
  Paint _ballPaint;
  Paint _bgPaint;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(area, _bgPaint);
    canvas.drawCircle(Offset(ball.x, ball.y), ball.radius, _ballPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
