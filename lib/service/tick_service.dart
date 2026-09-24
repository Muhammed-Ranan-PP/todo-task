import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/model/tick_model.dart';

class TickService {
  final Box<Tick> tickBox = Hive.box<Tick>("ticks");
  Future<void>addTick(Tick tick)async{
   await tickBox.add(tick);
  }
  List<Tick>getTick(){
    return tickBox.values.toList();
  }
  Future<void>updateTick(int key,Tick tick)async{
    await tickBox.put(key, tick);
  }
  Future<void>deleteTick(int key)async{
    await tickBox.delete(key);
  }
}