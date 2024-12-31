import 'package:flutter/widgets.dart';

extension Navigation<T> on BuildContext {
  Future<T?> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<T?> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<T?> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
  bool canPop() => Navigator.of(this).canPop();
}

extension MediaQry on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  Size get sizePX => MediaQuery.of(this).size;
  double get height => MediaQuery.of(this).size.height;
}
