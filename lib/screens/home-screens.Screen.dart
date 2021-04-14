import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_part1_and_part2/BLoC/database_bloc.dart';
import 'package:my_app_part1_and_part2/screens/addTask.Screen.dart';
import 'package:my_app_part1_and_part2/widgets/task-screen-body.widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // final _dataBloc = Provider.of<DataBloc>(context);
    final _databaseBloc = BlocProvider.of<DatabaseBloc>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => BlocProvider.value(
                value: _databaseBloc,
                child: AddTaskScreen(),
              ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 5, right: 5, top: 60, bottom: 5),
          child: BlocBuilder<DatabaseBloc, DatabaseState>(
            bloc: _databaseBloc,
            builder: (context, DatabaseState state) {
              return state is DatabaseLoadedState
                  ? TaskScreenBody(
                      taskList: state.taskList,
                    )
                  : Center(
                      child: Icon(
                        Icons.list_alt,
                        color: Colors.deepOrange,
                        size: 80,
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
