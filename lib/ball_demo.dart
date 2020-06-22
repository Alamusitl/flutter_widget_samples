import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_widget_samples/widgets/ball.dart';

class RunBallDemo extends StatefulWidget {
  @override
  _RunBallDemoState createState() => _RunBallDemoState();
}

class _RunBallDemoState extends State<RunBallDemo> with SingleTickerProviderStateMixin {
  Rect _area;
  Ball _ball;
  Color _bgColor;

  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    _area = Offset(10.0, 10.0) & Size(300.0, 300.0);
    _ball = Ball(
      accelerationX: 0.0,
      accelerationY: 0.1,
      velocityX: 4.0,
      velocityY: -2.0,
      x: 10.0 + 150.0,
      y: 10.0 + 150.0,
      radius: 10,
      color: Colors.blueAccent,
    );
    _bgColor = Color.fromARGB(148, 198, 246, 248);
    animationController = AnimationController(duration: Duration(days: 2), vsync: this);
    animationController.addListener(() {
      updateBall();
      setState(() {});
    });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: RunBall(ball: _ball, area: _area, bgColor: _bgColor),
      ),
    );
  }

  // 更新ball 信息
  updateBall() {
    _ball.x += _ball.velocityX;
    _ball.y += _ball.velocityY;
    _ball.velocityX += _ball.accelerationX;
    _ball.velocityY += _ball.accelerationY;
    bool touchBound = false;
    // 限定下边界
    if (_ball.y > _area.bottom - _ball.radius) {
      _ball.y = _area.bottom - _ball.radius;
      _ball.velocityY = -_ball.velocityY;
      _ball.color = randomColor();
    }
    // 限定上边界
    if (_ball.y < _area.top + _ball.radius) {
      _ball.y = _area.top + _ball.radius;
      _ball.velocityY = -_ball.velocityY;
      touchBound = true;
      _ball.color = randomColor();
    }
    // 限定左边界
    if (_ball.x < _area.left + _ball.radius) {
      _ball.x = _area.left + _ball.radius;
      _ball.velocityX = -_ball.velocityX;
      _ball.color = randomColor();
    }
    // 限定右边界
    if (_ball.x > _area.right - _ball.radius) {
      _ball.x = _area.right - _ball.radius;
      _ball.velocityX = -_ball.velocityX;
      _ball.color = randomColor();
    }
  }

  Color randomColor() {
    Random random = Random();
    return Color.fromARGB(255, random.nextInt(256), random.nextInt(256), random.nextInt(256));
  }
}
