import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hook_app/countdown_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

extension Normaliaze on num {
  num normalize(
    num selfRangeMax,
    num selfRangeMin, [
    num normalizeMax = 1.0,
    num normalizeMin = 0.0,
  ]) =>
      (normalizeMax - normalizeMin) *
          ((this - selfRangeMin) / (selfRangeMax - selfRangeMin)) +
      normalizeMin;
}

const imageHeight = 300.0;

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final opacity = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1.0,
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    final size = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1.0,
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    final controller = useScrollController();

    useEffect(() {
      controller.addListener(() {
        final newOpacity = max(imageHeight - controller.offset, 0.0);
        final normalized = newOpacity.normalize(0.0, imageHeight).toDouble();
        opacity.value = normalized;
        size.value = normalized;
      });
      return null;
    }, [controller]);
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Column(
        children: [
          SizeTransition(
            sizeFactor: size,
            axis: Axis.vertical,
            axisAlignment: -1.0,
            child: FadeTransition(
              opacity: opacity,
              child: Image.asset(
                'assets/images/myimage.png',
                height: imageHeight,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              // scrollDirection: Axis.vertical,
              controller: controller,
              itemBuilder: (context, index) =>
                  ListTile(leading: Text(' my tile ${index + 1}')),
              itemCount: 100,
            ),
          ),
        ],
      ),
    );
  }
}
