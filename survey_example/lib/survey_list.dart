import 'package:flutter/material.dart';
import 'package:survey/survey.dart';
import 'package:survey/widget/step_survey.dart';
import 'package:survey/widget/survey_classic.dart';
import 'package:survey/widget/survey_emoji.dart';
import 'package:survey/widget/survey_multiple_select.dart';
import 'package:survey/widget/survey_single_select.dart';
import 'package:survey/widget/survey_slider.dart';
import 'package:survey/widget/survey_stars.dart';
import 'package:survey/widget/survey_true_false.dart';

class SurveyList extends StatefulWidget {
  @override
  _SurveyListState createState() => _SurveyListState();
}

class _SurveyListState extends State<SurveyList> {
  List<StepSurvey> listSurvey = List();
  int _currentStep = 0;

  SurveyCallback callbackSlider;
  SurveyCallback callbackEmoji;
  SurveyCallback callbackStar;
  SurveyCallback callbackStatus;
  SurveyCallback callbackClassic;
  SurveyCallback callbackSingle;
  SurveyCallback callbackMultiple;

  @override
  void initState() {
    super.initState();
  }


  initList() {
    listSurvey.clear();
    listSurvey.add(_slider);
    listSurvey.add(_emoji);
    listSurvey.add(_star);
    listSurvey.add(_trueFalse);
    listSurvey.add(_singleSelect);
    listSurvey.add(_multipleSelect);
    listSurvey.add(_classic);
  }

  List<Step> get _listSteps {
    initList();
    List<Step> list = List();
    for (var i = 0; i < listSurvey.length; i++) {
      StepSurvey stepSurvey = listSurvey.elementAt(i);

      list.add(Step(
        title: Text(stepSurvey.title),
        subtitle: stepSurvey.isRequired ? Text("Belirtilmesi zorunlu alan") : null,
        content: stepSurvey.widget,
        isActive: _currentStep == i, //
        state: _currentStep == i ? StepState.editing : (_currentStep > i ? StepState.indexed : StepState.disabled),
      ));
    }

    return list;
  }

  alertScreen() {
    String s = "";

    s += "\nSlider: " + callbackSlider.toString();
    s += "\nEmoji: " + callbackEmoji.toString();
    s += "\nStar: " + callbackStar.toString();
    s += "\nStatus: " + callbackStatus.toString();
    s += "\nSingle: " + callbackSingle.toString();
    s += "\nMultiple: " + callbackMultiple.toString();
    s += "\nClassic: " + callbackClassic.toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(s),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepTapped: (index) {
          if (index < _currentStep) {
            setState(() => _currentStep = index);
          }
        },
        controlsBuilder: (BuildContext c, {VoidCallback onStepContinue, VoidCallback onStepCancel}) => Container(),
        steps: _listSteps,
      ),
      floatingActionButton: _fab,
    );
  }

  get _fab {
    final fabClose = FloatingActionButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Icon(Icons.done),
      backgroundColor: Colors.green,
      onPressed: () => alertScreen(),
    );
    final fabNext = FloatingActionButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Icon(Icons.chevron_right_rounded),
      backgroundColor: Colors.blue,
      onPressed: () => setState(() => _currentStep++),
    );
    final fabStop = FloatingActionButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Icon(Icons.priority_high_rounded),
      backgroundColor: Colors.red,
      onPressed: () => setState(() => _currentStep++),
    );

    StepSurvey stepSurvey = listSurvey.elementAt(_currentStep);

    if (!stepSurvey.isRequired) {
      // zorunlu alan değil
      return (_currentStep == _listSteps.length - 1) ? fabClose : fabNext;
    } else {
      if (stepSurvey.callback != null) {
        if (!stepSurvey.callback.isEmpty)
          return (_currentStep == _listSteps.length - 1) ? fabClose : fabNext;
        else
          return fabStop;
      }
    }
  }

  get _classic {
    Widget w = SurveyClassic(
      context: context,
      placeHolder: "Değerlendirmenizi yazınız...",
      onResult: (SurveyCallback callback) {
        setState(() => callbackClassic = callback);
      },
    );
    return StepSurvey(
      title: "Uygulama hakkında ne düşünüyorsunuz ?",
      callback: callbackClassic,
      isRequired: true,
      widget: w,
    );
  }

  get _singleSelect {
    final w = SurveySingleSelect(
      context: context,
      options: ["Yazılım Geliştirme", "Yazılım Destek", "Teknik Destek"],
      onResult: (SurveyCallback callback) {
        setState(() => callbackSingle = callback);
      },
    );
    return StepSurvey(
      title: "Proje yönetiminde hangi departmanda görev almaktasınız ?",
      callback: callbackSingle,
      isRequired: true,
      widget: w,
    );
  }

  get _multipleSelect {
    final w = SurveyMultipleSelect(
      context: context,
      options: ["Spor yapmak", "Müzik dinlemek", "Kitap okumak"],
      onResult: (SurveyCallback callback) {
        setState(() => callbackMultiple = callback);
      },
    );
    return StepSurvey(
      title: "Hobileriniz nelerdir ?",
      callback: callbackMultiple,
      widget: w,
    );
  }

  get _trueFalse {
    final w = SurveyTrueFalse(
      context: context,
      titlePositive: "Evet",
      titleNegative: "Hayır",
      onResult: (SurveyCallback callback) {
        setState(() => callbackStatus = callback);
      },
    );
    return StepSurvey(
      title: "Daha önce bu uygulamayı kullandınız mı ?",
      callback: callbackStatus,
      isRequired: true,
      widget: w,
    );
  }

  get _star {
    final w = SurveyStars(
      context: context,
      onResult: (SurveyCallback callback) {
        setState(() => callbackStar = callback);
      },
    );
    return StepSurvey(
      title: "Puanınızı belirtmek ister miydiniz ?",
      callback: callbackStar,
      isRequired: true,
      widget: w,
    );
  }

  get _emoji {
    final w = SurveyEmoji(
      context: context,
      onResult: (SurveyCallback callback) {
        setState(() => callbackEmoji = callback);
      },
    );
    return StepSurvey(
      title: "Bugün kendinizi nasıl hissediyorsunuz ?",
      callback: callbackEmoji,
      isRequired: true,
      widget: w,
    );
  }

  get _slider {
    final w = SurveySlider(
      context: context,
      color: Colors.red,
      max: 100,
      onResult: (SurveyCallback callback) {
        setState(() => callbackSlider = callback);
      },
    );
    return StepSurvey(
      title: "Derecelendirme yapmak ister misiniz ?",
      callback: callbackSlider,
      widget: w,
    );
  }
}
