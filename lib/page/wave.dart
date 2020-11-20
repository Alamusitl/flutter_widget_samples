import 'package:flutter/material.dart';
import 'package:flutter_widget_samples/util/ui_util.dart';
import 'package:flutter_widget_samples/widgets/wave.dart';

class WavePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: UiUtil.getDeviceWidth(context),
      child: WaveWidget(
        bgColor: Colors.lightBlue,
//       imageProvider: AssetImage('assets/pic/ic_headimg.png'),
//       imgSize: Size(50.0, 0.0),
        size: Size(300.0, 500.0),
      ),
    );
  }
}
