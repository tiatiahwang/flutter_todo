import 'package:flutter/material.dart';
import 'package:flutter_todo/data/hive_data_store.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_todo/models/task.dart';
import 'package:flutter_todo/views/home/home_view.dart';

Future<void> main() async {
  // Init Hive DB before run App
  await Hive.initFlutter();

  // Register Hive Adapter
  Hive.registerAdapter<Task>(TaskAdapter());

  // Open box
  Box box = await Hive.openBox<Task>(HiveDataStore.boxName);

  // Delete data from yesterday
  for (var task in box.values) {
    if (task.createdAtTime.day != DateTime.now().day) {
      task.delete();
    }
  }
  runApp(BaseWidget(child: const MyApp()));
}

// pass data between widgets
class BaseWidget extends InheritedWidget {
  BaseWidget({super.key, required this.child}) : super(child: child);

  final HiveDataStore dataStore = HiveDataStore();
  @override
  final Widget child;

  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError('Could not find ancestor widget of type BaseWidget');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          displayMedium: TextStyle(color: Colors.white, fontSize: 21),
          displaySmall: TextStyle(
            color: Color.fromARGB(255, 234, 234, 234),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          headlineMedium: TextStyle(color: Colors.grey, fontSize: 17),
          headlineSmall: TextStyle(color: Colors.grey, fontSize: 16),
          titleSmall: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          titleLarge: TextStyle(
            fontSize: 40,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),

      home: const HomeView(),
    );
  }
}
