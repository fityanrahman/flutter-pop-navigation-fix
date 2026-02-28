import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router_experiment/const/app_routes_const.dart';
import 'package:router_experiment/const/hero_tag_const.dart';
import 'package:router_experiment/service/shared_preference_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:router_experiment/screens/bloc/list_screen/list_screen_cubit.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ListScreenCubit(SharedPreferenceService())..loadData(),
      child: BlocBuilder<ListScreenCubit, ListScreenState>(
        builder: (context, state) {
          if (state.status == ListScreenStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == ListScreenStatus.failure) {
            return Column(
              children: [
                Text('Failed to load data: ${state.error}'),
                TextButton(
                  onPressed: () {
                    context.read<ListScreenCubit>().loadData();
                  },
                  child: Text('Reload Data'),
                ),
              ],
            );
          }
          return Scaffold(
            appBar: AppBar(title: const Text('List Screen')),
            body: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(title: Text(state.list![index]));
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: state.list!.length,
            ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 16,
              children: [
                FloatingActionButton(
                  heroTag: HeroTagConst.clearListButton,
                  onPressed: () {
                    context.read<ListScreenCubit>().clearData();
                  },
                  child: const Icon(Icons.clear),
                ),
                FloatingActionButton(
                  heroTag: HeroTagConst.addListButton,
                  onPressed: () async {
                    final result = await context.push(
                      AppRoutesConst.addItemScreen,
                    );
                    log('[ListScreen] ${result.toString()}');

                    if (result != null) {
                      context.read<ListScreenCubit>().loadData();
                    }
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
