import 'package:flutter/material.dart';

class SelectDemo extends StatefulWidget {
  @override
  _SelectDemoState createState() => _SelectDemoState();
}

class _SelectDemoState extends State<SelectDemo> {
  int value;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Expanded(
        child: DropdownButton(
          value: value,
          hint: Text('选择'),
          items: [1, 2, 3]
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text('$e'),
                ),
              )
              .toList(),
          onChanged: (newValue) {
            setState(() {
              value = newValue;
            });
          },
        ),
      ),
    );
  }
}
