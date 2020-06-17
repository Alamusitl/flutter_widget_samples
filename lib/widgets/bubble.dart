import 'dart:math';

import 'package:flutter/material.dart';

enum BubbleCornerPosition { top, bottom, left, right }

class Bubble extends StatelessWidget {
  Bubble({
    Key key,
    this.width,
    this.height,
    this.cornerPosition = BubbleCornerPosition.top,
    this.cornerHeight = 12.0,
    this.cornerAngle = 60.0,
    this.cornerOffset = 0.0,
    this.radius = 8.0,
    this.color = Colors.white,
    this.strokeColor = Colors.black,
    this.strokeWidth = 4.0,
    this.padding = EdgeInsets.zero,
    this.child,
  })  : assert((cornerAngle > 0.0 && cornerAngle < 180.0),
            'Corner angle must be in between 0.0 ~ 180.0'),
        assert((cornerHeight > 0.0), 'Corner height must greet than 0.0'),
        assert((radius > 0.0), 'Radius must greet than 0.0'),
        assert(width > radius * 2, 'Width must be greet than $radius * 2'),
        assert(height > radius * 2, 'Height must be greet than $radius * 2'),
        super(key: key);

  final double width;

  final double height;

  final BubbleCornerPosition cornerPosition;

  final double cornerHeight;

  final double cornerAngle;

  final double cornerOffset;

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
      width: width,
      height: height,
      child: Stack(
        children: [
          CustomPaint(
            painter: _BubblePainter(
              cornerHeight: cornerHeight,
              cornerAngle: cornerAngle,
              cornerOffset: cornerOffset,
              color: color,
              strokeColor: strokeColor,
              strokeWidth: strokeWidth,
            ),
          ),
          _wrapToPadding(),
        ],
      ),
    );
  }

  Widget _wrapToPadding() {
    EdgeInsetsGeometry enhance = EdgeInsets.only(
      left: cornerPosition == BubbleCornerPosition.left ? cornerHeight : 0.0,
      top: cornerPosition == BubbleCornerPosition.top ? cornerHeight : 0.0,
      right: cornerPosition == BubbleCornerPosition.right ? cornerHeight : 0.0,
      bottom: cornerPosition == BubbleCornerPosition.bottom ? cornerHeight : 0.0,
    );
    return Padding(
      padding: enhance.add(padding),
      child: Center(child: child),
    );
  }
}

class _BubblePainter extends CustomPainter {
  _BubblePainter({
    this.width,
    this.height,
    this.position,
    this.cornerHeight,
    this.cornerAngle,
    this.cornerOffset,
    this.radius,
    this.color,
    this.strokeColor,
    this.strokeWidth,
  })  : _bgPaint = Paint()
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

  final BubbleCornerPosition position;

  final double cornerHeight;

  final double cornerAngle;

  final double cornerOffset;

  final double radius;

  final Color color;

  final Color strokeColor;

  final double strokeWidth;

  Paint _bgPaint;

  Paint _strokePaint;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();

    path.arcTo(
      Rect.fromCircle(
        center: Offset(_checkLeft(radius), _checkTop(radius)),
        radius: radius,
      ),
      pi,
      pi * 0.5,
      false,
    );
    path.lineTo(_checkLeft(radius + cornerOffset), _checkTop(0.0));

    path.close();
    canvas.drawPath(path, _bgPaint);
    canvas.drawPath(path, _strokePaint);
  }

  double _checkLeft(double value) {
    return position == BubbleCornerPosition.left ? value + cornerHeight : value;
  }

  double _checkTop(double value) {
    return position == BubbleCornerPosition.top ? value + cornerHeight : value;
  }

  double _checkRight(double value) {
    return position == BubbleCornerPosition.right ? value + cornerHeight : value;
  }

  double _checkBottom(double value) {
    return position == BubbleCornerPosition.bottom ? value + cornerHeight : value;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
