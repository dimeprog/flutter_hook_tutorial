import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hook_app/countdown_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final countdown = useMemoized(() => CountdowmProvider(from: 20));
    final notifier = useListenable(countdown);
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Column(
        children: [
          Container(
            // color: Colors.black,
            height: 400,
            width: double.infinity,
            child: Column(children: [Text(notifier.value.toString())]),
          ),
        ],
      ),
    );
  }
}
