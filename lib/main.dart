import 'package:commandpattern/command_history.dart';
import 'package:commandpattern/commands/change_color_command.dart';
import 'package:commandpattern/shape.dart';
import 'package:flutter/material.dart';

import 'command.dart';
import 'commands/change_height_command.dart';
import 'commands/change_width_command.dart';
import 'widgets/command_history_column.dart';
import 'widgets/platform_button.dart';
import 'widgets/shape_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CommandHistory _commandHistory = CommandHistory();
  final Shape _shape = Shape.initial();

  void _changeColor() {
    final command = ChangeColorCommand(_shape);
    _executeCommand(command);
  }

  void _executeCommand(Command command) {
    setState(() {
      command.execute();
      _commandHistory.add(command);
    });
  }

  void _changeHeight() {
    final command = ChangeHeightCommand(_shape);
    _executeCommand(command);
  }

  void _changeWidth() {
    final command = ChangeWidthCommand(_shape);
    _executeCommand(command);
  }

  void _undo() {
    setState(() {
      _commandHistory.undo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                ShapeContainer(
                  shape: _shape,
                ),
                const SizedBox(height: 10),
                PlatformButton(
                  materialColor: Colors.black,
                  materialTextColor: Colors.white,
                  onPressed: _changeColor,
                  text: 'Change color',
                ),
                PlatformButton(
                  materialColor: Colors.black,
                  materialTextColor: Colors.white,
                  onPressed: _changeHeight,
                  text: 'Change height',
                ),
                PlatformButton(
                  materialColor: Colors.black,
                  materialTextColor: Colors.white,
                  onPressed: _changeWidth,
                  text: 'Change width',
                ),
                const Divider(),
                PlatformButton(
                  materialColor: Colors.black,
                  materialTextColor: Colors.white,
                  onPressed: _commandHistory.isEmpty ? null : _undo,
                  text: 'Undo',
                ),
                const SizedBox(height: 50),
                Row(
                  children: <Widget>[
                    CommandHistoryColumn(
                      commandList: _commandHistory.commandHistoryList,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )));
  }
}
