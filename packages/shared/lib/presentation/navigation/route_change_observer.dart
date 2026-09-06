import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RouteChangeNotifier() {
  final Set<VoidCallback> _listeners = {};

  void addRouteListener(VoidCallback listener) => _listeners.add(listener);

  void removeRouteListener(VoidCallback listener) => _listeners.remove(listener);

  void notifyRouteChanged() {
    for (final listener in _listeners.toList()) {
      listener();
    }
  }
}

// * kaisel attaches one observer per navigator and requires a fresh instance for each, so this
// * stays a plain class that forwards into the shared notifier
class RouteChangeObserver({
  required final RouteChangeNotifier _notifier,
}) extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _notifier.notifyRouteChanged();

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _notifier.notifyRouteChanged();

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _notifier.notifyRouteChanged();

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      _notifier.notifyRouteChanged();
}
