import 'package:shared_preferences/shared_preferences.dart';

class VisitPref {
  final String prefName = 'VISIT_FLAG';

  Future<bool> getInitialVisitFlag() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool visitFlag = prefs.getBool(prefName) ?? true;
    return Future<bool>.value(visitFlag);
  }

  Future setVisitFlag(bool visitFlag) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(prefName, visitFlag);
  }
}
