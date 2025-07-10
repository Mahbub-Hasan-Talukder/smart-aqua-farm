import 'package:hive_flutter/hive_flutter.dart';

class HiveServices {
  static final String onBoardBox = 'onBoard';
  static final String authBox = 'auth';

  Future<void> _openBox({String? boxName}) async {
    if (boxName == null) {
      await Hive.openBox(onBoardBox);
      await Hive.openBox(authBox);
    } else {
      Hive.openBox(boxName);
    }
  }

  Future<Box> _getBox(String boxName) async {
    if (!await Hive.boxExists(boxName)) await _openBox(boxName: boxName);
    return Hive.box(boxName);
  }

  Future<void> init() async {
    await Hive.initFlutter();
    await _openBox();
  }

  Future<T?> getValue<T>({required String key, required String boxName}) async {
    final value = (await _getBox(boxName)).get(key);
    if (value is! T && value != null) {
      throw Exception(
        'Hive data type mismatched: expected $T, got ${value.runtimeType}',
      );
    }
    return value as T?;
  }

  Future<void> setValue({
    required String key,
    required dynamic value,
    required String boxName,
  }) async {
    final box = await _getBox(boxName);
    await box.put(key, value);
  }

  Future<void> delete({required String key, required String boxName}) async {
    final box = await _getBox(boxName);
    await box.delete(key);
  }

  Future<void> clear({required String boxName}) async {
    final box = await _getBox(boxName);
    await box.clear();
  }
}
