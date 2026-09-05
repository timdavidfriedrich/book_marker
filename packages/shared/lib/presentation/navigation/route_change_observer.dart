import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RouteChangeObserver extends NavigatorObserver {
  final Set<VoidCallback> _listeners = {};

  void addRouteListener(VoidCallback listener) => _listeners.add(listener);

  void removeRouteListener(VoidCallback listener) => _listeners.remove(listener);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) => _notify();

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) => _notify();

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) => _notify();

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) => _notify();

  void _notify() {
    for (final listener in _listeners.toList()) {
      listener();
    }
  }
}
