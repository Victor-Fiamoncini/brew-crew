import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:brew_crew/styles/theme.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors['primary'],
      child: Center(
        child: SpinKitChasingDots(
          color: colors['secundary'],
        ),
      ),
    );
  }
}
