import 'package:clocker/models/pin/pin.dart';
import 'package:clocker/services/database.service.dart';
import 'package:flutter/material.dart';

import 'package:clocker/pages/welcome.page.dart';
import './services/pins-db.service.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        '/welcome': (context) => const WelcomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _handlePlusPress() async {
    final now = DateTime.now();
    final newPin = Pin(
        value: "1234", isActive: true, createdAt: now.millisecondsSinceEpoch);

    try {
      final insertionResult = await PinsDbService.insertPin(newPin);

      print(insertionResult);
    } on Exception catch (e) {
      print('an exception was thrown');
      print(e.toString());
    }

    setState(() {
      _counter++;
    });
  }

  void _logAllPins() async {
    final pinsMaps = await PinsDbService.getAllPins();
    int index = 0;

    for (final item in pinsMaps) {
      print('index: $index');
      print(item['id']);
      print(item['value']);
      print(item['is_active']);
      print(item['created_at']);
      index++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(onPressed: _logAllPins, child: const Text('Heh')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handlePlusPress,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
