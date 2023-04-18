import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/views/add_todo_page.dart';
import 'package:todo_app/views/edit_todo_page.dart';

import 'views/todo_list_page.dart';
import 'view_models/todo_list_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoListViewModel()..init()),
      ],
      child: MaterialApp(
        title: 'TODO App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/add_todo': (_) => AddTodoPage(),
          '/edit_todo': (_) => EditTodoPage(args: ModalRoute.of(_)?.settings.arguments as EditTodoArguments),
        },
        home: TodoListPage(),
      ),
    );
  }
}