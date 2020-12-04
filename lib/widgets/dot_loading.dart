import 'package:flutter/material.dart';

class DotLoading extends AnimatedWidget {
  const DotLoading({
    Key key,
    Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10,
      child: Text('.'),
    );
  }
}
