import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Notes Screen')),
      body: const Center(
        child: Text('Add Notes Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pop(true);
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}