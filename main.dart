import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TimerNotifier extends Notifier<DateTime> {
  @override
  DateTime build() {
    _update();
    return DateTime.now();
  }

  void _update() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      state = DateTime.now();
    });
  }
}

final timerProvider =
    NotifierProvider<TimerNotifier, DateTime>(() => TimerNotifier());

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App!!',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(timerProvider);
    String formattedDate = DateFormat("yMMMMEEEEd").format(timer);
    String formattedTimer = DateFormat("HH:mm:ss").format(timer);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$formattedTimer',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.2,
                
              ),
            ),
            Text("$formattedDate",
                style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}
