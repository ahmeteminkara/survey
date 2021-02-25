import 'package:flutter/material.dart';
import 'package:survey/survey.dart';

class SurveyTrueFalse extends StatefulWidget {
  final BuildContext context;
  final Function(SurveyCallback callback) onResult;

  final bool useCard;

  final Survey survey;
  final String question;
  final String titlePositive;
  final String titleNegative;
  final Color colorPositive;
  final Color colorNegative;

  SurveyTrueFalse({
    @required this.context,
    @required this.onResult,
    this.question,
    this.useCard = false,
    @required this.titlePositive,
    @required this.titleNegative,
    Color colorPositive,
    Color colorNegative,
  })  : assert(titlePositive != null),
        assert(titleNegative != null),
        assert(titlePositive.length > 0 && titlePositive.length < 6),
        assert(titleNegative.length > 0 && titleNegative.length < 6),
        this.colorPositive = colorPositive ?? Colors.green,
        this.colorNegative = colorNegative ?? Colors.red,
        this.survey = Survey(
          context: context,
          question: question,
          useCard: useCard,
        );

  @override
  _SurveyTrueFalseState createState() => _SurveyTrueFalseState();
}

class _SurveyTrueFalseState extends State<SurveyTrueFalse> {
  String selected = "";

  Duration duration = Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    return widget.survey.build(_ui);
  }

  Widget get _ui {
    Color bgColor;
    if (selected.isEmpty) {
      bgColor = Colors.grey[200];
    } else {
      bgColor = selected == widget.titlePositive ? widget.colorNegative.withAlpha(100) : widget.colorPositive.withAlpha(100);
    }
    return Container(
      alignment: Alignment.centerLeft,
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 0,
        color: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            button(
              true,
              widget.titlePositive,
              selected == widget.titlePositive,
              widget.colorPositive,
            ),
            button(
              false,
              widget.titleNegative,
              selected == widget.titleNegative,
              widget.colorNegative,
            ),
          ],
        ),
      ),
    );
  }

  Widget button(bool isPositive, String title, bool isSelected, Color color) {
    TextStyle textStyle = TextStyle(
      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
      fontSize: Survey.fontSizeContent,
      color: selected.isEmpty ? Colors.black87 : (isSelected ? Colors.white : color),
    );

    final fixW = 100.0;

    double width = 0;
    if (selected.isEmpty) {
      width = fixW;
    } else {
      width = isSelected ? fixW + (fixW * 0.3) : fixW - (fixW * 0.3);
    }

    return InkWell(
      onTap: () {
        setState(() => selected = title);
        widget.onResult(SurveyCallback.fromStatus(selected == widget.titlePositive));
      },
      child: AnimatedContainer(
          width: width,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isSelected ? color : Colors.transparent,
          ),
          alignment: Alignment.center,
          duration: duration,
          child: Text(title, style: textStyle)),
    );
  }
}
