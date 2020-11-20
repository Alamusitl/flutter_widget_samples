import 'package:flutter/material.dart';

class BezierCurvePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipPath(
          clipper: BottomClipper(),
          child: Container(
            color: Colors.deepOrangeAccent,
            height: 200,
          ),
        ),
      ],
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // 单个弧线
    // path.lineTo(0, 0);// 第一点
    // path.lineTo(0, size.height - 50.0);// 第二点
    // var firstControlPoint = Offset(size.width / 2, size.height);// 第一曲线控制点
    // var firstEndPoint = Offset(size.width, size.height - 50.0);// 第一曲线结束点
    // path.quadraticBezierTo(// 形成曲线
    //   firstControlPoint.dx,
    //   firstControlPoint.dy,
    //   firstEndPoint.dx,
    //   firstEndPoint.dy,
    // );
    // path.lineTo(size.width, size.height - 50.0);// 第三点
    // path.lineTo(size.width, 0);// 第四点

    // 波浪线
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

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
