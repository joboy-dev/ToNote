import 'package:flutter/material.dart';

navigatorPushReplacementNamed(BuildContext context, String route) {
  Navigator.pushReplacementNamed(context, route);
}

navigatorPushNamed(BuildContext context, String route) {
  Navigator.pushNamed(context, route);
}

// navigatorPop(BuildContext context) {
//   Navigator.pop(context);
// }

navigatorPop(BuildContext context) {
  Navigator.of(context).pop();
}

navigatorPushReplacement(BuildContext context, Widget screen) {
  Navigator.of(context).pushReplacement(screenRoute(screen));
}

navigatorPush(BuildContext context, Widget screen) {
  Navigator.of(context).push(screenRoute(screen));
}

Route screenRoute(Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // const begin = Offset(0.0, 1.0);
      // const end = Offset.zero;
      // final tween = Tween(begin: begin, end: end);

      // const begin = Offset(0.0, 1.0);
      // const end = Offset.zero;

      // var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeIn)); 
      // final offsetAnimation = animation.drive(tween);

      var tween = Tween(begin: 0.0, end: 1.0);
      final scaleAnimation = animation.drive(tween);

      return ScaleTransition(
        scale: scaleAnimation,
        child: child
      );
    },
  );
}


