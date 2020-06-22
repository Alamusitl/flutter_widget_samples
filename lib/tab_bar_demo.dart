import 'package:flutter/material.dart' hide TabBar;
import 'package:flutter/widgets.dart';

import 'widgets/tab_bar.dart';

class TabBarDemo extends StatefulWidget {
  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> with SingleTickerProviderStateMixin {
  TabController tabController;

  List<String> tabs = ['First', 'Second', 'Three'];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: null,
        title:
//        Center(
//          child: Wrap(
//            children: tabs.map((item) {
//              return Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: InkWell(
//                  child: Text(item),
//                  onTap: () {},
//                ),
//              );
//            }).toList(),
//          ),
//        ),

            TabBar(
          controller: tabController,
          labelStyle: TextStyle(fontSize: 20.0),
          unselectedLabelStyle: TextStyle(fontSize: 16.0),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          tabs: tabs.map((item) {
            return Tab(text: item);
          }).toList(),
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: tabs.map((item) {
            return Container(
              child: Center(
                child: Text(item),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
