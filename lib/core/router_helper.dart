import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouterHelper{
  static final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  Future<Object?> goto<T>({bool replace=false, bool clean=false, required Widget screen,}) async {
    final context = _navigationKey.currentState!.context;

    if (replace) {
      return await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => screen));
    } else if (clean) {
      return await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => screen), (route) => false,);
    } else {
      return await Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
    }
  }

  void goBack({dynamic data}) {
    final BuildContext context = _navigationKey.currentState!.context;
    Navigator.of(context).canPop() ? Navigator.of(context).pop(data) : null;
  }
}

RouterHelper routerHelper= RouterHelper();