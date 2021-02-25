import 'package:flutter/material.dart';
import 'package:survey/survey.dart';

class SurveyMultipleSelect extends StatefulWidget {
  final BuildContext context;
  final Function(SurveyCallback callback) onResult;
  final String question;

  final bool useCard;

  final Survey survey;
  final List<String> options;

  SurveyMultipleSelect({
    @required this.context,
    @required this.onResult,
    this.question,
    this.useCard = false,
    @required this.options,
  })  : assert(options != null),
        assert(options.isNotEmpty),
        this.survey = Survey(
          context: context,
          question: question,
          useCard: useCard,
        );

  @override
  _SurveyMultipleSelectState createState() => _SurveyMultipleSelectState();
}

class _SurveyMultipleSelectState extends State<SurveyMultipleSelect> {
  List<String> _characters = List();

  @override
  Widget build(BuildContext context) {
    return widget.survey.build(_ui);
  }

  Widget get _ui {
    return Column(
      children: widget.options.map((item) {
        final icon = _characters.contains(item)
            ? Icon(
                Icons.check_box_rounded,
                color: Theme.of(context).primaryColor,
                size: 24,
              )
            : Icon(
                Icons.check_box_outline_blank_rounded,
                color: Theme.of(context).disabledColor,
                size: 24,
              );

        final b = ListTile(
          contentPadding: EdgeInsets.zero,
          leading: icon,
          title: Text(item),
          onTap: () {
            setState(() {
              if (_characters.contains(item))
                _characters.remove(item);
              else
                _characters.add(item);
            });

            widget.onResult(SurveyCallback.fromTextList(_characters));
          },
        );
        return b;
      }).toList(),
    );
  }
}
