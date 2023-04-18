import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo_item.dart';
import '../view_models/todo_list_view_model.dart';
import 'edit_todo_page.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoListViewModel = Provider.of<TodoListViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('TODO List'),
      ),
      body: ListView.builder(
        itemCount: todoListViewModel.items.length,
        itemBuilder: (context, index) {
          final item = todoListViewModel.items[index];
          return ListTile(
            title: Text(item.title),
            subtitle: Text(item.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    final result = await Navigator.of(context).pushNamed(
                      '/edit_todo',
                      arguments: EditTodoArguments(
                        index: index,
                        item: item,
                      ),
                    );
                    if (result is TodoItem) {
                      todoListViewModel.updateItem(index, result);
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Delete TODO'),
                        content: Text('Are you sure you want to delete this item?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                              todoListViewModel.removeItem(index);
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            onTap: () async {
              final result = await Navigator.of(context).pushNamed(
                '/edit_todo',
                arguments: EditTodoArguments(
                  index: index,
                  item: item,
                ),
              );
              if (result is TodoItem) {
                todoListViewModel.updateItem(index, result);
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).pushNamed('/add_todo');
          if (result is TodoItem) {
            todoListViewModel.addItem(result);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
