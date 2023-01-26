import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_examples/auto_dispose/counter_controller.dart';

final counterProvider =
    StateNotifierProvider.autoDispose<CounterController, int>(
  (ref) {
    //ref.keepAlive();
    final link = ref.keepAlive();
    final timer = Timer(const Duration(seconds: 10), () {
      link.close();
    });
    ref.onDispose(() => timer.cancel());
    return CounterController();
  },
);

class Counter extends ConsumerWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Text('$counter', style: const TextStyle(fontSize: 40)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
