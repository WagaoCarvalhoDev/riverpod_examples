import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterController extends StateNotifier<int> {
  CounterController() : super(0);

  increment() => state++;
}
