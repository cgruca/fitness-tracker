import 'package:hive/hive.dart';

part 'exercise.g.dart';

@HiveType(typeId: 1) //typeId should be unique for each model
class Exercise extends HiveObject{
  @HiveField(0)
  String name;

  @HiveField(1)
  String? force;

  @HiveField(2)
  String level;

  @HiveField(3)
  String? mechanic;

  @HiveField(4)
  String? equipment;

  @HiveField(5)
  List<String> primaryMuscles;

  @HiveField(6)
  List<String> secondaryMuscles;

  @HiveField(7)
  List<String> instructions;

  @HiveField(8)
  String category;

  @HiveField(9)
  List<String> images;

  @HiveField(10)
  String id;

  Exercise({
    required this.name,
    this.force,
    required this.level,
    this.mechanic,
    this.equipment,
    required this.primaryMuscles,
    required this.secondaryMuscles,
    required this.instructions,
    required this.category,
    required this.images,
    required this.id,
  });

    // Optionally, override toString() for better console printing
  @override
  String toString() {
    return '{name: $name, force: $force, level: $level, mechanic: $mechanic, equipment: $equipment, primaryMuscles: $primaryMuscles, secondaryMuscles: $secondaryMuscles, instructions: $instructions, category: $category, images: $images, id: $id}';
  }
}