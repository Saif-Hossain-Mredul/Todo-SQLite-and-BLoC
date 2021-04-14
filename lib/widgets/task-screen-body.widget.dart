import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_part1_and_part2/BLoC/database_bloc.dart';
import 'package:my_app_part1_and_part2/widgets/task-tile.widget.dart';

class TaskScreenBody extends StatelessWidget {
  getCompletedTaskCount(List tasks) {
    return tasks.where((task) => task.status == 1).toList().length;
  }

  @override
  Widget build(BuildContext context) {
    final _databaseBloc = BlocProvider.of<DatabaseBloc>(context);

    return BlocBuilder<DatabaseBloc, DatabaseState>(
      bloc: _databaseBloc,
      builder: (context, DatabaseState state) {
        return state is DatabaseLoadedState
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'My tasks',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      '${getCompletedTaskCount(state.taskList)} of ${state.taskList.length}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.taskList.length,
                      itemBuilder: (context, index) {
                        return TaskTile(
                          task: state.taskList[index],
                        );
                      },
                    ),
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
