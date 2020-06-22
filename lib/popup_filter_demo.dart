import 'package:flutter/material.dart';
import 'package:flutter_widget_samples/widgets/popup_filter.dart';

class PopupFilterDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        child: Column(
          children: [
            PopupWrapper(
              child: Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(border: Border.all()),
                child: Text('测试'),
              ),
              popupView: Material(
                child: Container(
                  child: Column(
                    children: [
                      Text('测试信息'),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '测试信息输入',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
