import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BottomDragDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: DragContainer(),
        )
      ],
    );
  }
}

class DragContainer extends StatefulWidget {
  @override
  _DragContainerState createState() => _DragContainerState();
}

class _DragContainerState extends State<DragContainer> with SingleTickerProviderStateMixin {
  Offset offset = Offset(0.0, 0.0);

  GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer> getVerticalRecognizer() {
    return GestureRecognizerFactoryWithHandlers(
        () => VerticalDragGestureRecognizer(), this._initializer);
  }

  GestureRecognizerFactoryWithHandlers<HorizontalDragGestureRecognizer> getHorizontalRecognizer() {
    return GestureRecognizerFactoryWithHandlers(() => HorizontalDragGestureRecognizer(),
        (recognizer) {
      recognizer
        ..onStart = _onStart
        ..onCancel = _onCancel
        ..onDown = _onDown
        ..onUpdate = _onUpdate
        ..onEnd = _onEnd;
    });
  }

  void _initializer(VerticalDragGestureRecognizer recognizer) {
    recognizer
      ..onStart = _onStart
      ..onCancel = _onCancel
      ..onDown = _onDown
      ..onUpdate = _onUpdate
      ..onEnd = _onEnd;
  }

  ///接受触摸事件
  void _onCancel() {
    print('取消触摸');
  }

  ///接受触摸事件
  void _onDown(DragDownDetails details) {
    print('按下屏幕${details.globalPosition}');
  }

  ///接受触摸事件
  void _onStart(DragStartDetails details) {
    print('触摸屏幕${details.globalPosition}');
  }

  ///垂直移动
  void _onUpdate(DragUpdateDetails details) {
    offset = offset + details.delta;
    print('移动${details.delta} - $offset');
    setState(() {});
  }

  ///手指离开屏幕
  void _onEnd(DragEndDetails details) {
    print('离开屏幕');
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: RawGestureDetector(
        gestures: {
          VerticalDragGestureRecognizer: getVerticalRecognizer(),
          HorizontalDragGestureRecognizer: getHorizontalRecognizer(),
        },
        child: Container(
          width: 100.0,
          height: 100.0,
          color: Colors.brown,
        ),
      ),
    );
  }
}
