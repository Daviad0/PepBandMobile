import 'package:flutter/material.dart';
import 'package:pep/constants.dart';

import 'helpers.dart';

class VariableSizeContainerExample extends StatefulWidget {
  VariableSizeContainerExample();

  @override
  _VariableSizeContainerExampleState createState() => _VariableSizeContainerExampleState();
}

class _VariableSizeContainerExampleState extends State<VariableSizeContainerExample> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: new Duration(milliseconds: (animationDuration * 1000).round()),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  toggleContainer() {
    if (_animation.status != AnimationStatus.completed) {
      _controller.forward();
    } else {
      _controller.animateBack(0, duration: Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      child: Padding(
        padding: EdgeInsets.only(left: 20),
        child: Container(
          decoration: headerBoxStyle,
          padding: padding,
          height: getHeightFactor(context, 0.1),
          width: getWidthFactor(context, 0.4),
        ),
      ),
    );


  }
}