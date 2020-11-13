import 'package:flutter_widget_samples/page/ball_demo.dart';
import 'package:flutter_widget_samples/page/bottom_drag_demo.dart';
import 'package:flutter_widget_samples/page/bubble_demo.dart';
import 'package:flutter_widget_samples/page/clip.dart';
import 'package:flutter_widget_samples/page/data_table_demo.dart';
import 'package:flutter_widget_samples/page/popup_filter_demo.dart';
import 'package:flutter_widget_samples/page/select_demo.dart';
import 'package:flutter_widget_samples/page/tab_bar_demo.dart';

class Config {
  static Map<String, Function> get routes => {
        'Bottom Drag': (_) => BottomDragDemo(),
        'Dropdown': (_) => SelectDemo(),
        'Compact TabBar': (_) => TabBarDemo(),
        'Popup filter': (_) => PopupFilterDemo(),
        'Bubble': (_) => BubbleDemo(),
        'Run Ball': (_) => RunBallDemo(),
        'Data Table': (_) => DataTableDemo(),
        'Clip': (_) => CurvePage(),
      };
}
