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
    // TODO: implement initState
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
              decoration: const InputDecoration(
                labelText: 'Item Name',
              ),
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
      await _sharedPreferenceService.write(KeyPairConst.listPrefsKey, item);

      if (mounted) {
        context.push(AppRoutesConst.addNotesScreen);
      }
    }
  }
}