import 'package:flutter/material.dart';
import 'package:habittracker/components/my_button.dart';
import 'package:habittracker/components/my_drawer.dart';
import 'package:habittracker/components/my_habit_tile.dart';
import 'package:habittracker/components/my_heat_map.dart';
import 'package:habittracker/databases/habit_database.dart';
import 'package:habittracker/models/habit.dart';
import 'package:habittracker/util/habit_util.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    //read the existing habits on app startup
    //Provider.of<HabitDatabase>(context).readHabits();
    context.read<HabitDatabase>().readHabits();

    // TODO: implement initState
    super.initState();
  }

  final textController = TextEditingController();

  //change completion
  changeCompletion(int id, bool? value) {
    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(id, value);
    }
  }

  //edit a habit
  void editHabit(Habit habit) {
    textController.text = habit.name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Habit'),
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
                  String habitName = textController.text;
                  Navigator.pop(context);
                  context
                      .read<HabitDatabase>()
                      .updateHabitName(habit.id, habitName);
                  textController.clear();
                },
                text: 'Update',
              ),
            ],
          ),
        ],
      ),
    );
  }

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
                  String newHabit = textController.text;
                  Navigator.pop(context);
                  context.read<HabitDatabase>().addHabit(newHabit);
                  textController.clear();
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
      //drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: [
          //HeatMap Calendar
          _buildHeatMap(),
          //HabitList
          _buildHabitList(),
        ],
      ),
      drawer: MyDrawer(),
    );
  }

  Widget _buildHeatMap() {
    //habit db
    final habitDb = context.watch<HabitDatabase>();
    //current habits
    List<Habit> currentHabits = habitDb.currentHabits;

    //return heatmap ui
    return FutureBuilder<DateTime?>(
      future: habitDb.getFirstOpenDate(),
      builder: (context, snapshot) {
        // once the first date is available then we can return the heatmap
        if (snapshot.hasData) {
          return MyHeatMap(
            firstDate: snapshot.data!,
            datasets: getHeatMapDataset(currentHabits),
          );
        }
        //handle state where data is not available
        else {
          return Container();
        }
      },
    );
  }

  Widget _buildHabitList() {
    List<Habit> currentHabits = context.watch<HabitDatabase>().currentHabits;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: currentHabits.length,
        itemBuilder: (context, index) {
          //get each individual habit
          final habit = currentHabits[index];

          //check if the habit is completed today
          bool isCompletedToday = isHabitCompletedToday(habit.completedDays);
          //return habit tile to ui
          return MyHabitTile(
            habit: habit,
            isCompleted: isCompletedToday,
            onEditTap: () => editHabit(habit),
            onChanged: (value) {
              changeCompletion(habit.id, value);
            },
          );
        },
      ),
    );
  }
}
