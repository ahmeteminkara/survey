import 'package:flutter/material.dart';
import 'package:survey/survey.dart';

class SurveySingleSelect extends StatefulWidget {
  final BuildContext context;
  final Function(SurveyCallback callback) onResult;
  final String question;

  final bool useCard;

  final Survey survey;
  final List<String> options;

  SurveySingleSelect({
    @required this.context,
    @required this.onResult,
    this.useCard = false,
    this.question,
    @required this.options,
  })  : assert(options != null),
        assert(options.isNotEmpty),
        this.survey = Survey(
          context: context,
          question: question,
          useCard: useCard,
        );

  @override
  _SurveySingleSelectState createState() => _SurveySingleSelectState();
}

class _SurveySingleSelectState extends State<SurveySingleSelect> {
  String _character = "";

  @override
  Widget build(BuildContext context) {
    return widget.survey.build(_ui);
  }

  Widget get _ui {
    return Column(
      children: widget.options.map((item) {
        final icon = _character == item
            ? Icon(
                Icons.radio_button_checked,
                color: Theme.of(context).primaryColor,
                size: 24,
              )
            : Icon(
                Icons.radio_button_off,
                color: Theme.of(context).disabledColor,
                size: 24,
              );

        final b = ListTile(
          contentPadding: EdgeInsets.zero,
          leading: icon,
          title: Text(item),
          onTap: () {
            setState(() {
              _character = item;
            });
            widget.onResult(SurveyCallback.fromText(item));
          },
        );
        return b;
      }).toList(),
    );
  }
}
