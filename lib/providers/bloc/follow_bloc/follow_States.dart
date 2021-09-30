import 'package:flutter/material.dart';

abstract class FollowStates {}

class FollowInitialState extends FollowStates {}

class FollowedState extends FollowStates {
  String message;
  FollowedState({
    @required this.message,
  });
}

class UnFollowedState extends FollowStates {
  String message;
  UnFollowedState({
    @required this.message,
  });
}

class FollowExceptionState extends FollowStates {
  String error;
  FollowExceptionState({
    @required this.error,
  });
}
