import 'package:flutter/material.dart';
import 'package:todo/model/tick_model.dart';
import 'package:todo/service/tick_service.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final service = TickService();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  void saveTick() {
    final tick = Tick(
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
    );
    service.addTick(tick);

    setState(() {
      tickList();
    });

    titleController.clear();
    descriptionController.clear();
  }

  List<Tick> ticks = [];
  void tickList() {
    ticks = service.getTick();
  }

  @override
  void initState() {
    super.initState();
    tickList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("TO DO", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: "Title"),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: "Description"),
          ),
          ElevatedButton(
            onPressed: () {
              saveTick();
            },
            child: Text("Save"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ticks.length,
              itemBuilder: (context, index) {
                final tick = ticks[index];
                return SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: ListTile(
                    title: Text(tick.title),
                    subtitle: Text(tick.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await service.deleteTick(tick.key);
                            setState(() {
                              tickList();
                            });
                          },
                          icon: Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () async {
                            final editTitleController = TextEditingController(
                              text: tick.title,
                            );
                            final editDescriptioncontroller =
                                TextEditingController(text: tick.description);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Edit todo"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: editTitleController,
                                        decoration: InputDecoration(
                                          hint: Text("Title"),
                                        ),
                                      ),
                                      TextField(
                                        controller: editDescriptioncontroller,
                                        decoration: InputDecoration(
                                          hintText: "Description",
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async{
                                        final newTitle = editTitleController
                                            .text
                                            .trim();
                                        final newDescription= editDescriptioncontroller.text.trim();
                                            final updatedTick = Tick(title: newTitle,description: newDescription
                                            );
                                            await service.updateTick(tick.key, updatedTick);
                                            setState(() {
                                              tickList();
                                            });
                                            Navigator.pop(context);
                                      },
                                      child: Text("Update"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
