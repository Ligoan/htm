import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class Pref {
  static late Box _box;
  static Future<void> initialize() async {
    // for initializing hive to use app directory
    Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
    _box = Hive.box(name: 'myData');
  }

  static bool get showOnBoarding =>
      _box.get('showOnBoarding', defaultValue: true);
  static set showOnBoarding(bool v) => _box.put('showOnBoarding', v);
}
