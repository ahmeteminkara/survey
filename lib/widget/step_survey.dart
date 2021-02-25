import 'package:flutter/material.dart';
import 'package:survey/survey.dart';

class StepSurvey {
  final bool isRequired;
  final SurveyCallback callback;
  final Widget widget;
  final String title;

  StepSurvey({
    @required this.title,
    @required this.callback,
    @required this.widget,
    this.isRequired = false,
  });
}
