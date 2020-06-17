import 'package:flutter/material.dart';
import 'package:flutter_widget_samples/bottom_drag_simple.dart';
import 'package:flutter_widget_samples/bubble_simple.dart';
import 'package:flutter_widget_samples/popup_filter_simple.dart';
import 'package:flutter_widget_samples/select_simple.dart';
import 'package:flutter_widget_samples/tab_bar_simple.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widget Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      onGenerateRoute: (RouteSettings settings) {
        String name = settings.name;
        Function routeBuilder = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => WidgetPage(
            title: name,
            builder: routeBuilder,
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Map<String, Function> routes = {
    'Bottom Drag': (_) => BottomDragSimple(),
    'Dropdown': (_) => SelectSimple(),
    'Compact TabBar': (_) => TabBarSimple(),
    'Popup filter': (_) => PopupFilterSimple(),
    'Bubble': (_) => BubbleSimple(),
  };

  int value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Widget Demo'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          String route = routes.keys.toList()[index];
          String pageName = routes.keys.toList()[index];
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, route, arguments: routes[route]);
            },
            title: Text(
              pageName,
              style: TextStyle(fontSize: 20.0),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: routes.length,
      ),
    );
  }
}

class WidgetPage extends StatelessWidget {
  WidgetPage({Key key, this.title, this.builder}) : super(key: key);

  final String title;
  final Function builder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: builder(context),
    );
  }
}
