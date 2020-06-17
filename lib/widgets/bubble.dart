import 'dart:math';

import 'package:flutter/material.dart';

enum BubbleIndicatorPosition { top, bottom, left, right }

class Bubble extends StatelessWidget {
  Bubble({
    Key key,
    this.width,
    this.height,
    this.indicatorPosition = BubbleIndicatorPosition.top,
    this.indicatorHeight = 12.0,
    this.indicatorAngle = 60.0,
    this.indicatorOffset = 0.0,
    this.radius = 8.0,
    this.color = Colors.white,
    this.strokeColor = Colors.black,
    this.strokeWidth = 4.0,
    this.padding = EdgeInsets.zero,
    this.child,
  })  : assert((indicatorAngle > 0.0 && indicatorAngle < 180.0),
            'Corner angle must be in between 0.0 ~ 180.0'),
        assert((indicatorHeight > 0.0), 'Corner height must greet than 0.0'),
        assert((radius > 0.0), 'Radius must greet than 0.0'),
        assert(width > radius * 2, 'Width must be greet than $radius * 2'),
        assert(height > radius * 2, 'Height must be greet than $radius * 2'),
        super(key: key);

  final double width;

  final double height;

  final BubbleIndicatorPosition indicatorPosition;

  final double indicatorHeight;

  final double indicatorAngle;

  final double indicatorOffset;

  /// Bubble shape radius
  final double radius;

  /// Bubble background color
  final Color color;

  /// Bubble stroke color
  final Color strokeColor;

  /// Bubble stroke width
  final double strokeWidth;

  /// Bubble inner padding to child
  final EdgeInsetsGeometry padding;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: width,
      height: height,
      child: Stack(
        children: [
          CustomPaint(
            painter: _BubblePainter(
              width,
              height,
              indicatorPosition,
              indicatorHeight,
              indicatorAngle,
              indicatorOffset,
              radius,
              color,
              strokeColor,
              strokeWidth,
            ),
          ),
          _wrapToPadding(),
        ],
      ),
    );
  }

  Widget _wrapToPadding() {
    EdgeInsetsGeometry enhance = EdgeInsets.only(
      left: indicatorPosition == BubbleIndicatorPosition.left ? indicatorHeight : 0.0,
      top: indicatorPosition == BubbleIndicatorPosition.top ? indicatorHeight : 0.0,
      right: indicatorPosition == BubbleIndicatorPosition.right ? indicatorHeight : 0.0,
      bottom: indicatorPosition == BubbleIndicatorPosition.bottom ? indicatorHeight : 0.0,
    );
    return Padding(
      padding: enhance.add(padding),
      child: Center(child: child),
    );
  }
}

class _BubblePainter extends CustomPainter {
  _BubblePainter(
    this.width,
    this.height,
    this.position,
    this.indicatorHeight,
    this.indicatorAngle,
    this.indicatorOffset,
    this.radius,
    this.color,
    this.strokeColor,
    this.strokeWidth,
  )   : _bgPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = color
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth,
        _strokePaint = Paint()
          ..style = PaintingStyle.stroke
          ..color = strokeColor
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth;

  final double width;

  final double height;

  final BubbleIndicatorPosition position;

  final double indicatorHeight;

  final double indicatorAngle;

  final double indicatorOffset;

  final double radius;

  final Color color;

  final Color strokeColor;

  final double strokeWidth;

  Paint _bgPaint;

  Paint _strokePaint;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();

    // 左上角Corner
    path.arcTo(
      Rect.fromCircle(
        center: Offset(_checkLeft(radius), _checkTop(radius)),
        radius: radius,
      ),
      pi,
      pi * 0.5,
      false,
    );

    // 上侧Indicator起始点
    path.lineTo(_checkLeft(radius + indicatorOffset), _checkTop(0.0));
    if (position == BubbleIndicatorPosition.top) {
      // 上侧Indicator
      path.lineTo(radius + indicatorOffset + _indicatorWidth / 2, 0.0);
      path.lineTo(radius + indicatorOffset + _indicatorWidth, indicatorHeight);
    }
    // 右上角起始点
    path.lineTo(_checkRight(radius), _checkTop(0.0));

    // 右上角Corner
    path.arcTo(
      Rect.fromCircle(
        center: Offset(_checkRight(radius), _checkTop(radius)),
        radius: radius,
      ),
      -pi * 0.5,
      pi * 0.5,
      false,
    );

    // 右侧Indicator起始点
    path.lineTo(_checkRight(0.0), _checkTop(radius + indicatorOffset));
    if (position == BubbleIndicatorPosition.right) {
      // 右侧Indicator
      path.lineTo(width, radius + indicatorOffset + _indicatorWidth / 2);
      path.lineTo(width - indicatorHeight, radius + indicatorOffset + _indicatorWidth);
    }

    // 右下角起始点
    path.lineTo(_checkRight(0.0), _checkBottom(radius));

    // 右下角Corner
    path.arcTo(
      Rect.fromCircle(
        center: Offset(_checkRight(radius), _checkBottom(radius)),
        radius: radius,
      ),
      pi * 0,
      pi * 0.5,
      false,
    );

    // 下侧Indicator起始点
    path.lineTo(_checkRight(radius + indicatorOffset), _checkBottom(0.0));
    if (position == BubbleIndicatorPosition.bottom) {
      // 下侧Indicator
      path.lineTo(width - radius - indicatorOffset - _indicatorWidth / 2, height);
      path.lineTo(width - radius - indicatorOffset - _indicatorWidth, height - indicatorHeight);
    }
    // 左下角Corner起始点
    path.lineTo(_checkLeft(radius), _checkBottom(0.0));

    // 左下角Corner
    path.arcTo(
      Rect.fromCircle(center: Offset(_checkLeft(radius), _checkBottom(radius)), radius: radius),
      pi * 0.5,
      pi * 0.5,
      false,
    );

    //左侧Indicator起始点
    path.lineTo(_checkLeft(0.0), _checkBottom(radius + indicatorOffset));
    if (position == BubbleIndicatorPosition.left) {
      path.lineTo(0.0, height - radius - indicatorOffset - _indicatorWidth / 2);
      path.lineTo(indicatorHeight, height - radius - indicatorOffset - _indicatorWidth);
    }
    path.lineTo(_checkLeft(0.0), _checkTop(radius));

    path.close();
    canvas.drawPath(path, _bgPaint);
    canvas.drawPath(path, _strokePaint);
  }

  double _checkLeft(double value) {
    return position == BubbleIndicatorPosition.left ? value + indicatorHeight : value;
  }

  double _checkTop(double value) {
    return position == BubbleIndicatorPosition.top ? value + indicatorHeight : value;
  }

  double _checkRight(double value) {
    return position == BubbleIndicatorPosition.right
        ? width - value - indicatorHeight
        : width - value;
  }

  double _checkBottom(double value) {
    return position == BubbleIndicatorPosition.bottom
        ? height - value - indicatorHeight
        : height - value;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double get _indicatorWidth => indicatorHeight * tan(_angle(indicatorAngle * 0.5)) * 2;

  double _angle(double angle) {
    return angle * pi / 180;
  }
}
