import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const url =
    'https://images.unsplash.com/photo-1546587348-d12660c30c50?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=874&q=80';

extension CompatMap<T> on Iterable<T?> {
  Iterable<T> compatMap<E>([E? Function(T?)? transform]) =>
      map(transform ?? (e) => e).where((e) => e != null).cast();
}

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final future = useMemoized(
      () => NetworkAssetBundle(Uri.parse(url))
          .load(url)
          .then((data) => data.buffer.asUint8List())
          .then(
            (data) => Image.memory(data),
          ),
    );
    final image = useFuture(future);
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
              child: Column(children: [image.data].compatMap().toList())),
        ],
      ),
    );
  }
}
