import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router_experiment/const/app_routes_const.dart';
import 'package:router_experiment/const/hero_tag_const.dart';
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
    _loadData();
  }

  Future<void> _loadData() async {
    log('Loading data');
    await _sharedPreferenceService.init();

    final value = await _sharedPreferenceService.read(
      KeyPairConst.listPrefsKey,
    );

    if (!mounted) return;

    setState(() {
      _list = value ?? [];
    });
  }

    Future<void> _clearData() async {
    await _sharedPreferenceService.init();

    await _sharedPreferenceService.clear();

    if (!mounted) return;

    setState(() {
      _list = [];
    });

    log('List cleared');
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 16,
        children: [
          FloatingActionButton(
            heroTag: HeroTagConst.clearListButton,
            onPressed: () {
              _clearData();
            },
            child: const Icon(Icons.clear),
          ),
          FloatingActionButton(
            heroTag: HeroTagConst.addListButton,
            onPressed: () async {
              final result = await context.push(AppRoutesConst.addItemScreen);
              log('[ListScreen] ${result.toString()}');

              if (result != null) {
                _loadData();
              }
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
