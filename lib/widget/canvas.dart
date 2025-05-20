import 'package:flutter/material.dart';

class ScreenCanvas extends StatelessWidget {
  final String appBarTitleText;
  final List<Widget>? appBarActions;
  final Widget? bottomBar;
  final List<Widget> widgets;

  const ScreenCanvas({
    super.key,
    required this.widgets,
    required this.appBarTitleText,
    this.appBarActions,
    this.bottomBar,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: bottomBar,
        appBar: AppBar(
          actions: appBarActions,
          title: Text(appBarTitleText),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widgets,
          ),
        ),
      ),
    );
  }
}
