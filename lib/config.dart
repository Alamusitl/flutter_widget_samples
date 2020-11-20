import 'package:flutter_widget_samples/page/ball_demo.dart';
import 'package:flutter_widget_samples/page/bezier.dart';
import 'package:flutter_widget_samples/page/bottom_drag_demo.dart';
import 'package:flutter_widget_samples/page/bubble_demo.dart';
import 'package:flutter_widget_samples/page/compat_tab_bar.dart';
import 'package:flutter_widget_samples/page/custom_paint.dart';
import 'package:flutter_widget_samples/page/data_table_demo.dart';
import 'package:flutter_widget_samples/page/navigater_animation.dart';
import 'package:flutter_widget_samples/page/popup_filter_demo.dart';
import 'package:flutter_widget_samples/page/wave.dart';

class Config {
  static Map<String, Function> get routes => {
        '拖拽': (_) => BottomDragDemo(),
        'Compact TabBar': (_) => TabBarDemo(),
        'Popup filter': (_) => PopupFilterDemo(),
        'Bubble': (_) => BubbleDemo(),
        'Run Ball': (_) => RunBallDemo(),
        'Data Table': (_) => DataTableDemo(),
        'Clip-Bezier': (_) => BezierCurvePage(),
        'CustomPaint': (_) => CustomPaintPage(),
        '波浪': (_) => WavePage(),
        '自定义路由动画': (_) => CustomNavigateAnimation(),
      };
}
