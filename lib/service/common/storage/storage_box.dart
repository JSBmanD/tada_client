import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

/// Класс для контейнера хранилища объектов
class StorageBox<T> {
  @protected
  final String boxName;
  @protected
  Box<T> box;

  StorageBox({@required this.boxName}) : assert(boxName != null);

  /// Добавляет объект в хранилище
  add(String key, T val) {
    assert(key != null && key.length < 255);
    if (box.get(key, defaultValue: null) != null)
      throw new Exception('Object with key $key already exist');
    box.put(key, val);
  }

  /// Добавляет или обновляет объект хранилища
  addOrUpdate(String key, T val) {
    assert(key != null && key.length < 255);
    box.put(key, val);
  }

  /// Получает все объекты хранилища
  List<T> getAll() {
    final data = box.toMap();
    return data.values;
  }

  /// Получает объект хранилища по ключу
  T getByKey(String key) {
    final result = box.get(key, defaultValue: null);
    return result;
  }

  /// Обновляет объект хранилища по ключу
  updateByKey(String key, T val) {
    if (box.get(key, defaultValue: null) == null)
      throw new Exception('Object with key $key doesn\'t exist');
    box.put(key, val);
  }

  /// Удаляет объект хранилища по ключу
  deleteByKey(String key) {
    box.delete(key);
  }

  Future<void> init() async {
    box = await Hive.openBox(boxName);
  }
}
