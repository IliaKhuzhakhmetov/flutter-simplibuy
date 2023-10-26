import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

sealed class ApplicationState extends Equatable {
  const ApplicationState();

  @override
  List<Object?> get props => [];
}

class ApplicationInitial extends ApplicationState {
  const ApplicationInitial();
}

class ApplicationBrightnessChanged extends ApplicationState {
  final Brightness brightness;

  const ApplicationBrightnessChanged({required this.brightness});

  @override
  List<Object?> get props => [brightness];
}
