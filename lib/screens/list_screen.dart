import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:router_experiment/const/app_routes_const.dart';
import 'package:router_experiment/const/key_pair_const.dart';
import 'package:router_experiment/service/shared_preference_service.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService();
  List<String> _list = [];

  @override
  void initState() {
    super.initState();
    _sharedPreferenceService.init();
    _sharedPreferenceService.read(KeyPairConst.listPrefsKey).then((value) {
      setState(() {
        _list = value ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Screen')),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(title: Text(_list[index]));
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: _list.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRoutesConst.addItemScreen);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
