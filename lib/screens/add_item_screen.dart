import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:router_experiment/const/app_routes_const.dart';
import 'package:router_experiment/const/key_pair_const.dart';
import 'package:router_experiment/service/shared_preference_service.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  late final SharedPreferenceService _sharedPreferenceService;
  final _formKey = GlobalKey<FormState>();
  final _itemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _sharedPreferenceService = SharedPreferenceService();
    _sharedPreferenceService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Item Screen')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _itemController,
              decoration: const InputDecoration(labelText: 'Item Name'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter an item name';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addItem();
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  Future<void> _addItem() async {
    if (_formKey.currentState!.validate()) {
      final item = _itemController.text;
      await _sharedPreferenceService.init();

      // 1️⃣ Read existing list
      final existingList =
          await _sharedPreferenceService.read<List<String>>(
            KeyPairConst.listPrefsKey,
          ) ??
          [];

      // 2️⃣ Add new item
      existingList.add(item);

      // 3️⃣ Save entire list
      await _sharedPreferenceService.write(
        KeyPairConst.listPrefsKey,
        existingList,
      );

      if (mounted) {
        context.push(AppRoutesConst.addNotesScreen);
      }
    }
  }
}
