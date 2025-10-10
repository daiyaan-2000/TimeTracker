import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracker/providers/bottomNavState_provider.dart';
import 'package:time_tracker/providers/task_provider.dart';
import 'package:time_tracker/widgets/app_bar.dart';
import 'dart:async';

class AddNew extends ConsumerStatefulWidget {
  const AddNew({super.key});

  //final Function(Map<String, dynamic>) onSave;

  @override
  ConsumerState<AddNew> createState() => _AddNewState();
}

class _AddNewState extends ConsumerState<AddNew> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _detailsCtrl = TextEditingController();
  final _minutesCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final taskList = ref.read(tasksProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Task'), centerTitle: true),
      backgroundColor: Color.fromRGBO(250, 250, 255, 100),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Title
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(
                  labelText: 'Task title',
                  hintText: 'e.g. Flutter project',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Please enter a title'
                    : null,
              ),
              const SizedBox(height: 16),

              // Descriptions (comma-separated)
              TextFormField(
                controller: _detailsCtrl,
                decoration: const InputDecoration(
                  labelText: 'Task descriptions (comma separated)',
                  hintText: 'e.g. UI Design, Testing, Code Review',
                ),
              ),
              const SizedBox(height: 16),

              // Total minutes
              TextFormField(
                controller: _minutesCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Total minutes',
                  hintText: 'e.g. 90',
                ),
                validator: (v) {
                  final n = int.tryParse(v ?? '');
                  if (n == null || n <= 0) return 'Enter a positive number';
                  return null;
                },
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() != true) return;

                  final title = _titleCtrl.text;
                  final details = _detailsCtrl.text
                      .split(',')
                      .map((e) => e.trim())
                      .where((e) => e.isNotEmpty)
                      .toList();
                  final minutes = int.parse(_minutesCtrl.text);

                  /*

                  final newTask = {
                    'iconInfo': 'assets/icons/monitor.png', //TEMPORARY
                    'title': title,
                    'timer': '00:00',
                    'details': details,
                    'minutes': minutes,
                  };

                  */

                  taskList.addTask(
                    title: title,
                    details: details,
                    totalMinutes: minutes,
                  );

                  ref.read(selectedTabProvider.notifier).state = 0;
                  //widget.onSave(newTask);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Task added: $title ($minutes min)'),
                    ),
                  );
                },
                child: const Text('Save Task'),
              ),

              // Save button
            ],
          ),
        ),
      ),
    );
  }
}
