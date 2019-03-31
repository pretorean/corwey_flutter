import 'package:bloc/bloc.dart';
import 'package:corwey_flutter/CorweyApp.dart';
import 'package:corwey_flutter/CorweyBlocDelegate.dart';
import 'package:corwey_flutter/UserRepository.dart';
import 'package:flutter/material.dart';

void main() {
  BlocSupervisor().delegate = CorweyBlocDelegate();
  runApp(CorweyApp(userRepository: UserRepository()));
}
