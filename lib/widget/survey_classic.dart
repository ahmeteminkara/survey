import 'package:flutter/material.dart';
import 'package:survey/survey.dart';

class SurveyClassic extends StatelessWidget {
  final BuildContext context;
  final Function(SurveyCallback callback) onResult;
  final String question;
  final String placeHolder;
  
  final bool useCard;

  final Survey survey;

  SurveyClassic({
    @required this.context,
    @required this.onResult,
    this.question,
    this.useCard = false,
    @required this.placeHolder,
  })  : assert(placeHolder != null),
        assert(placeHolder.length > 0),
        this.survey = Survey(
          context: context,
          question: question,
          useCard: useCard,
        );

  @override
  Widget build(BuildContext context) {
    return survey.build(_ui);
  }

  Widget get _ui {
    return TextFormField(
      onFieldSubmitted: (s) => onResult(SurveyCallback.fromText(s)),
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: placeHolder,
        hintStyle: TextStyle(fontSize: Survey.fontSizeContent),
      ),
      minLines: 5,
      maxLines: 7,
    );
  }
}
