import 'package:flutter/material.dart';

class CustomContainerAnimated extends StatefulWidget {
  final String title;
  final String pathToFile;
  final WidgetBuilder builder;
  final bool delayStartup;

  CustomContainerAnimated(
      {required this.title,
      required this.pathToFile,
      required this.builder,
      this.delayStartup = false})
      : assert(!pathToFile.contains("-"),
            "Don't use minus character in filenames.");

  @override
  _CustomContainerAnimatedState createState() =>
      _CustomContainerAnimatedState();
}

class _CustomContainerAnimatedState extends State<CustomContainerAnimated> {
  var renderBuilder = true;

  @override
  void initState() {
    if (widget.delayStartup) {
      renderBuilder = false;
      Future.delayed(Duration(milliseconds: 500)).then((_) {
        setState(() => renderBuilder = true);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Widget _buildPage(BuildContext context) {
    // if (!renderBuilder) {
    //   return Container();
    // }
    return this.widget.builder(context);
  }
}
