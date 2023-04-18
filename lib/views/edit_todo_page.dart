import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/todo_item.dart';

class EditTodoPage extends StatefulWidget {
  final EditTodoArguments args;

  EditTodoPage({required this.args});

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();
  late final _titleController = TextEditingController(text: widget.args.item.title);
  late final _descriptionController = TextEditingController(text: widget.args.item.description);

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit TODO'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title is required';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final item = TodoItem(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    createdAt: widget.args.item.createdAt,
                    isCompleted: widget.args.item.isCompleted,
                  );
                  Navigator.of(context).pop(item);
                }
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditTodoArguments {
  final int index;
  final TodoItem item;

  EditTodoArguments({required this.index, required this.item});
}
