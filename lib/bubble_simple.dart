import 'package:flutter/material.dart';
import 'package:flutter_widget_samples/widgets/bubble.dart';

class BubbleSimple extends StatefulWidget {
  @override
  _BubbleSimpleState createState() => _BubbleSimpleState();
}

class _BubbleSimpleState extends State<BubbleSimple> {
  BubbleIndicatorPosition position;

  @override
  void initState() {
    super.initState();
    position = BubbleIndicatorPosition.top;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  setState(() {
                    position = BubbleIndicatorPosition.left;
                  });
                },
                child: Text('Left'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    position = BubbleIndicatorPosition.top;
                  });
                },
                child: Text('Top'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    position = BubbleIndicatorPosition.right;
                  });
                },
                child: Text('Right'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    position = BubbleIndicatorPosition.bottom;
                  });
                },
                child: Text('Bottom'),
              ),
            ],
          ),
          Bubble(
            width: 300,
            height: 220,
            indicatorPosition: position,
            indicatorOffset: 100.0,
            padding: EdgeInsets.all(8.0),
            color: Colors.red,
            radius: 30.0,
            strokeColor: Colors.green,
            child: Text(
              '你好，我是萌新 BubbleWidget！',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
