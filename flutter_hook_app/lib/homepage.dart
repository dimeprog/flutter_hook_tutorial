import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});
  Stream<String> getTime() => Stream.periodic(
        const Duration(seconds: 2),
        (_) => DateTime.now().toIso8601String(),
      );
  @override
  Widget build(BuildContext context) {
    final homeTitle = useStream(getTime());
    final controller = useTextEditingController();
    final text = useState('');
    useEffect(
      () {
        controller.addListener(() {
          text.value = controller.text;
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(homeTitle.data ?? 'HomePage'),
      ),
      body: Column(children: [
        const SizedBox(
          height: 70,
        ),
        TextField(
          controller: controller,
        ),
        const SizedBox(
          height: 20,
        ),
        Text('You typed ${text.value}'),
      ]),
    );
  }
}
