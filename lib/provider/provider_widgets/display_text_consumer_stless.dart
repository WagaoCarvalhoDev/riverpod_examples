import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myProvider = Provider((ref) => 'Test RiverPod consumer stLess');

class DisplayTextConsumerStLess extends StatelessWidget {
  const DisplayTextConsumerStLess({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(builder: (context, ref, child) {
        final text = ref.watch(myProvider);
        return Text(text);
      }),
    );
  }
}
