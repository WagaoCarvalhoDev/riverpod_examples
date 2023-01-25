import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_examples/state_notifier_provider/counter.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyHomePage(),
      );
}

final counterProvider = StateNotifierProvider<Counter, int>((ref) => Counter());

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    ref.listen(counterProvider, (previous, next) {
      if (next == 11) {
        ref.invalidate(counterProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Só sei contar até 10')),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('State Provider'),
        actions: [
          IconButton(
              onPressed: () {
                ref.invalidate(counterProvider);
                //ref.refresh(counterProvider);
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: Text(
          counter.toString(),
          style: const TextStyle(fontSize: 50),
        ),
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
