import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router_experiment/const/app_routes_const.dart';
import 'package:router_experiment/const/hero_tag_const.dart';
import 'package:router_experiment/service/shared_preference_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:router_experiment/screens/bloc/add_item/add_item_cubit.dart';

class AddItemScreen extends StatelessWidget {
  AddItemScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddItemCubit(SharedPreferenceService()),
      child: BlocConsumer<AddItemCubit, AddItemState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) async {
          if (state.status == AddItemStatus.success) {
            final result = await context.push(AppRoutesConst.addNotesScreen);
            log('[AddItemScreen] ${result.toString()}');

            if (result != null) {
              context.pop(result);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Add Item Screen')),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        context.read<AddItemCubit>().onChanged(value);
                      },
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
            ),
            floatingActionButton: FloatingActionButton(
              heroTag: HeroTagConst.confirmAddButton,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                context.read<AddItemCubit>().addItem();
                }
              },
              child: const Icon(Icons.check),
            ),
          );
        },
      ),
    );
  }
}
