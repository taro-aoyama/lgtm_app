import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo_item.dart';

class TodoListViewModel with ChangeNotifier {
  List<TodoItem> _items = [];
  final DateFormat _dateFormat = DateFormat('yyyy/MM/dd HH:mm:ss');


  List<TodoItem> get items => _items;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = prefs.getStringList('items') ?? [];
    _items = itemsJson.map((itemJson) {
      final itemMap = Map<String, dynamic>.from(json.decode(itemJson));
      return TodoItem(
        title: itemMap['title'],
        description: itemMap['description'],
        createdAt: _dateFormat.parse(itemMap['createdAt']),
        isCompleted: itemMap['isCompleted'],
      );
    }).toList();
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = _items.map((item) {
      final itemMap = {
        'title': item.title,
        'description': item.description,
        'createdAt': _dateFormat.format(item.createdAt),
        'isCompleted': item.isCompleted,
      };
      return json.encode(itemMap);
    }).toList();
    prefs.setStringList('items', itemsJson);
  }

  void addItem(TodoItem item) {
    _items.add(item);
    save();
    notifyListeners();
  }

  void toggleItemCompletion(int index) {
    _items[index].isCompleted = !_items[index].isCompleted;
    save();
    notifyListeners();
  }

  void updateItem(int index, TodoItem item) {
    _items[index] = item;
    save();
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    save();
    notifyListeners();
  }

}
