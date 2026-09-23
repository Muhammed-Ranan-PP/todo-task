import 'package:hive_flutter/hive_flutter.dart';
part 'tick_model.g.dart';

@HiveType(typeId:0)
class Tick extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

   Tick({
     required this.title,
     required this.description
   });

  
}