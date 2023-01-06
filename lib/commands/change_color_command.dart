import 'package:commandpattern/command.dart';
import 'package:commandpattern/shape.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class ChangeColorCommand implements Command {
  Shape shape;
  late Color previousColor;

  ChangeColorCommand(this.shape) {
    previousColor = shape.color;
  }

  @override
  void execute() {
    shape.color = Color.fromRGBO(
      random.integer(255),
      random.integer(255),
      random.integer(255),
      1.0,
    );
  }

  @override
  String getTitle() {
    return 'Change Color';
  }

  @override
  void undo() {
    shape.color = previousColor;
  }
}
