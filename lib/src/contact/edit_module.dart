import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class EditModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => Container();

  static Inject get to => Inject<EditModule>.of();
}
