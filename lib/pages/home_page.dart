import 'package:flutter/material.dart';
import 'package:habittracker/components/my_button.dart';
import 'package:habittracker/components/my_drawer.dart';
import 'package:habittracker/databases/habit_database.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
  //create a new habit
  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('New Habit'),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
              hintText: 'eg. 100 pushups',
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              )),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //cancel button
              MyButton(
                onPressed: () {
                  Navigator.pop(context);
                  textController.clear();
                },
                text: 'Cancel',
              ),
              //add habit
              MyButton(
                onPressed: () {
                  textController.clear();
                  Navigator.pop(context);
                  context.read<HabitDatabase>().addHabit(textController.text);
                },
                text: 'Add',
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: Icon(Icons.add),
      ),
    );
  }
}
