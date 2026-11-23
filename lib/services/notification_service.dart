// Demo only: no native alerts, background work or remote data.
import 'package:flutter/material.dart';
final dalilNavigatorKey = GlobalKey<NavigatorState>();
class NotificationService {
  NotificationService._();
  static final instance = NotificationService._();
  String? activeChatId;
  bool navigationReady = false;
  Future<void> openPending() async {}
}
