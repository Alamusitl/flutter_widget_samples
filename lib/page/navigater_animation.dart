import 'dart:math';

import 'package:flutter/material.dart';

class CustomNavigateAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: OutlineButton(
        child: Text('打开'),
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return ClipPath(
                    clipper: _CircleClipper(animation.value),
                    child: child,
                  );
                },
                child: _SecondPage(),
              );
            },
          ));
        },
      ),
    );
  }
}

class _CircleClipper extends CustomClipper<Path> {
  _CircleClipper(this.value);

  double value;

  @override
  Path getClip(Size size) {
    Path path = Path();
    double radius = value * sqrt(size.height * size.height + size.width * size.width) / 2;
    path.addOval(Rect.fromLTRB(
      size.width / 2 - radius,
      size.height / 2 - radius,
      size.width / 2 + radius,
      size.height / 2 + radius,
    ));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class _SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('测试页面')),
      body: Container(
        alignment: Alignment.center,
        color: Colors.amberAccent,
        child: OutlineButton(
          color: Colors.pinkAccent,
          child: Text('返回'),
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
      ),
    );
  }
}
