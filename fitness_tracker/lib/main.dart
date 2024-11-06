import 'package:flutter/material.dart';
import 'variables.dart';
import 'components/card.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'exercise.dart'; // Make sure this imports the model and the generated adapter file

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExerciseAdapter()); //add TypeAdapater
  await Hive.openBox<Exercise>('exercises');

  var exerciseBox = await Hive.openBox<Exercise>('exercises');

  // Load initial data if the box is empty
  if (exerciseBox.isEmpty) {
    log("BOX EMPTY");
    await loadInitialExercises(exerciseBox);
  } else {
    log("BOX FULL");
    List<Exercise> exercises = exerciseBox.values.toList();
    Exercise? firstExercise = exerciseBox.getAt(27); // retrieves the first item in the box
    print(firstExercise.toString()); // Will throw an error if firstExercise is null
  }

  runApp(const MyApp());
}

// Function to load initial exercises from JSON
Future<void> loadInitialExercises(Box<Exercise> exerciseBox) async {
  // Load the JSON file
  log('LOADING...');
  final String jsonString = await rootBundle.loadString('data/exercises.json');
  final data = await json.decode(jsonString);
  // print(data[0]);

  // Parse and add each exercise to the box
  for (var item in data) {
    final exercise = Exercise(
      name: item['name'],
      force: item['force'],
      level: item['level'],
      mechanic: item['mechanic'],
      equipment: item['equipment'],
      primaryMuscles: List<String>.from(item['primaryMuscles']),
      secondaryMuscles: List<String>.from(item['secondaryMuscles']),
      instructions: List<String>.from(item['instructions']),
      category: item['category'],
      images: List<String>.from(item['images']),
      id: item['id'],
    );

    await exerciseBox.add(exercise);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: AppColor.colorScheme,
        textTheme: AppText.textTheme,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Here'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final List<String> cardTexts = ['Hello', 'Welcome', 'Fitness Tips', 'Daily Goals', 'Workout Plan'];


  List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    log('here');
    // final String response = await rootBundle.loadString('data/exercises.json');
    // final data = await json.decode(response);
    var exerciseBox = await Hive.openBox<Exercise>('exercises');
    Exercise? firstExercise = exerciseBox.getAt(27);

    print(firstExercise.toString());
    var data = json.decode(firstExercise.toString());
    print(data);

    setState(() {
      _items = data;
    });
    final item1 = _items[0];
    log('item 0: $item1');


  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.bgColor,
        title: Text(widget.title, style: AppText.title),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
            child: const Text('Load Data'),
            onPressed: readJson,
          ),
          _items.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      return CardItem(text: _items[index]["name"]);
                    },
                  ),
                )
              : Container()
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
