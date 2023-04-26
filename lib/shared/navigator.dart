import 'package:flutter/material.dart';

navigatorPushReplacementNamed(BuildContext context, String route) {
  Navigator.pushReplacementNamed(context, route);
}

navigatorPushNamed(BuildContext context, String route) {
  Navigator.pushNamed(context, route);
}

navigatorPop(BuildContext context) {
  Navigator.pop(context);
}
