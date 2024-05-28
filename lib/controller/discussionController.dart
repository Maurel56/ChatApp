import 'package:flutter/material.dart';

class DiscussionController with WidgetsBindingObserver {
  bool _appIsInactive = false;

  void startObserving() {
    WidgetsBinding.instance.addObserver(this);
  }

  void stopObserving() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _appIsInactive = false;
      print('L\'application est devenue active');
    } else {
      _appIsInactive = true;
      print('L\'application est devenue inactive');
    }
  }

  bool isAppActive() {
    return !_appIsInactive;
  }
}
