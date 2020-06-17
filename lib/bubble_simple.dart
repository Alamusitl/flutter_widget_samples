import 'package:flutter/material.dart';
import 'package:flutter_widget_samples/widgets/bubble.dart';

class BubbleSimple extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Bubble(
          width: 300,
          height: 220,
          cornerPosition: BubbleCornerPosition.top,
          padding: EdgeInsets.all(8.0),
          color: Colors.red,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
