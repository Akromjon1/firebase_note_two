import 'package:hive_flutter/hive_flutter.dart';

class HiveService{

  static const dbName = "token_box";
  static final Box _box = Hive.box(dbName);

  static Future<void> setData<T>(StorageKey key, T value)async{
    await _box.put(key.name, value);
  }

  static readData(StorageKey key)async{
    await  _box.get(key.name, defaultValue: "No data");
  }

  static Future<void> removeData(StorageKey key) async {
    await _box.delete(key.name);
  }

}
enum StorageKey{
  uid
}