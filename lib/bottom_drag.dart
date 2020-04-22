import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BottomDrag extends StatefulWidget {
  @override
  _BottomDragState createState() => _BottomDragState();
}

class _BottomDragState extends State<BottomDrag> {
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

class _DragContainerState extends State<DragContainer>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  double offsetDistance = 0.0;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 250),
    );
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>
      getRecognizer() {
    return GestureRecognizerFactoryWithHandlers(
        () => VerticalDragGestureRecognizer(), this._initializer);
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
    print('垂直移动${details.delta}');
    offsetDistance = offsetDistance + details.delta.dy;
    setState(() {});
  }

  ///手指离开屏幕
  void _onEnd(DragEndDetails details) {
    print('离开屏幕');
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, offsetDistance),
      child: RawGestureDetector(
        gestures: {VerticalDragGestureRecognizer: getRecognizer()},
        child: Container(
          width: 100.0,
          height: 100.0,
          color: Colors.brown,
        ),
      ),
    );
  }
}
