import 'package:flutter/material.dart';

class SelectSimple extends StatefulWidget {
  @override
  _SelectSimpleState createState() => _SelectSimpleState();
}

class _SelectSimpleState extends State<SelectSimple> {
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
