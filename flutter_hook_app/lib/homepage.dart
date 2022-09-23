import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hook_app/countdown_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    late final StreamController<double> controller;
    controller = useStreamController<double>(onListen: () {
      controller.sink.add(0.0);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: StreamBuilder<double>(
        stream: controller.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final rotation = snapshot.data ?? 0.0;
            return GestureDetector(
              onTap: () {
                return controller.sink.add(rotation + 10.0);
              },
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(rotation / 360.0),
                child: Center(
                  child: Image.asset(
                    'assets/images/myimage.png',
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
