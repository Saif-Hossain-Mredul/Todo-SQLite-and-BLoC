import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_part1_and_part2/BLoC/database_bloc.dart';
import 'package:my_app_part1_and_part2/screens/addTask.Screen.dart';
import 'package:my_app_part1_and_part2/widgets/home-screen-body.widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                value: BlocProvider.of<DatabaseBloc>(context),
                child: AddTaskScreen(),
              ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: BlocBuilder<DatabaseBloc, DatabaseState>(
          bloc: BlocProvider.of<DatabaseBloc>(context),
          builder: (context, DatabaseState state) {
            return state is DatabaseLoadedState
                ? Padding(
                    padding: EdgeInsets.only(top: 60, bottom: 5),
                    child: HomeScreenBody(
                      taskList: state.taskList,
                    ),
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
    );
  }
}
