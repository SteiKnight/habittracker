import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/components/my_button.dart';
import 'package:habittracker/databases/habit_database.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';

class MyHabitTile extends StatelessWidget {
  final habit;
  final bool isCompleted;
  void Function()? onEditTap;
  void Function(bool?)? onChanged;
  MyHabitTile({
    super.key,
    required this.habit,
    required this.isCompleted,
    required this.onEditTap,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged != null) {
          onChanged!(!isCompleted);
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: isCompleted
              ? Colors.green
              : Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Transform.scale(
                  scale: 2,
                  child: CupertinoCheckbox(
                    activeColor: Colors.green.shade300,
                    value: isCompleted,
                    onChanged: onChanged,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  habit.name,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Builder(builder: (context) {
              return IconButton(
                onPressed: () {
                  showPopover(
                    arrowHeight: 4,
                    
                    arrowWidth: 10,
                    context: context,
                    bodyBuilder: (context) => IntrinsicWidth(
                      child: IntrinsicHeight(
                        child: Container(
                            margin: EdgeInsets.all(0),
                            
                            color: Theme.of(context).colorScheme.primary,
                            padding: EdgeInsets.all(0),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      onEditTap!();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 10),
                                      width: 50,
                                      //minWidth: 20,
                                      height: 30,

                                      child: Center(
                                        child: Text(
                                          'edit',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          content: Text(
                                            'Are you sure you want to delete this Habit?',
                                            textAlign: TextAlign.center,
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                MyButton(
                                                  text: 'cancel',
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                MyButton(
                                                  text: 'confirm',
                                                  onPressed: () {
                                                    context
                                                        .read<HabitDatabase>()
                                                        .deleteHabit(habit.id);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      width: 50,
                                      height: 30,
                                      child: Center(
                                        child: Text(
                                          'delete',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
