library survey;

import 'package:flutter/material.dart';

class SurveyCallback {
  List<String> _resultList;
  String _resultString;
  int _resultInt;
  bool _resultBool;

  SurveyCallback({
    List<String> resultList,
    String resultString,
    int resultInt,
    bool resultBool,
  })  : this._resultList = resultList,
        this._resultString = resultString,
        this._resultInt = resultInt,
        this._resultBool = resultBool;

  factory SurveyCallback.fromTextList(List<String> list) {
    return SurveyCallback(resultList: list);
  }
  factory SurveyCallback.fromText(String string) {
    return SurveyCallback(resultString: string);
  }
  factory SurveyCallback.fromNumber(int number) {
    return SurveyCallback(resultInt: number);
  }
  factory SurveyCallback.fromStatus(bool status) {
    return SurveyCallback(resultBool: status);
  }

  get textList => this._resultList;
  get text => this._resultString;
  get number => this._resultInt;
  get status => this._resultBool;

  @override
  String toString() {
    if (_resultBool != null) {
      return _resultBool.toString();
    } else if (_resultInt != null) {
      return _resultInt.toString();
    } else if (_resultList != null) {
      return _resultList.toString();
    } else if (_resultString != null) {
      return _resultString;
    } else {
      return "NULL Callback";
    }
  }

  bool get isEmpty {
    if (_resultBool != null) {
      return false;
    } else if (_resultInt != null) {
      return false;
    } else if (_resultList != null) {
      return false;
    } else if (_resultString != null) {
      return false;
    } else {
      return true;
    }
  }
}

class Survey {
  static double get fontSizeTitle => 18;
  static double get fontSizeContent => 15;

  BuildContext context;
  String question;
  bool useCard;

  Survey({
    @required this.context,
    this.question,
    this.useCard = false,
  }) : assert(context != null);

  Widget get questionText => Text(
        question,
        style: TextStyle(fontSize: fontSizeTitle),
      );

  Widget build(Widget widget) {
    final listTile = ListTile(
      contentPadding: EdgeInsets.all(4),
      title: question != null ? questionText : null,
      subtitle: Padding(
        padding: EdgeInsets.only(top: (question != null ? 10 : 0)),
        child: widget,
      ),
    );

    if (useCard) {
      return Card(
        margin: EdgeInsets.all(4),
        child: listTile,
      );
    }
    return listTile;
  }
}
