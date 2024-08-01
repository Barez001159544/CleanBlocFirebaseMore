import 'package:hive/hive.dart';

class HiveHelper{
  final String _boxName = "noteBox";

  Future<void> init() async {
      await Hive.openBox(_boxName);
  }

  Future<void> createOrUpdate(String key, dynamic data) async {
    final box = Hive.box(_boxName);
    await box.put(key, data);
  }

  Future<void> deleteValue(String key) async {
    final box = Hive.box(_boxName);
    await box.delete(key);
  }

  dynamic getValue({required String key}) {
    final box = Hive.box(_boxName);
    return box.get(key);
  }
}

HiveHelper hiveHelper = HiveHelper();