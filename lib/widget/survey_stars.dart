import 'package:flutter/material.dart';
import 'package:survey/survey.dart';

class SurveyStars extends StatefulWidget {
  final BuildContext context;
  final Function(SurveyCallback callback) onResult;
  final String question;

  final bool useCard;

  final Survey survey;
  final Color starColor;
  final double starSize;

  SurveyStars({
    @required this.context,
    @required this.onResult,
    this.question,
    this.useCard = false,
    this.starColor = Colors.deepOrange,
    this.starSize = 35,
  }) : this.survey = Survey(
          context: context,
          question: question,
          useCard: useCard,
        );

  @override
  _SurveyStarsState createState() => _SurveyStarsState();
}

class _SurveyStarsState extends State<SurveyStars> {
  int star = 0;

  @override
  Widget build(BuildContext context) {
    return widget.survey.build(_ui);
  }

  Widget get _ui {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(6, (index) => starWidget(index)),
    );
  }

  starWidget(int index) {
    if (index == 0) return Container();

/*

*/

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            star = index;
          });
          widget.onResult(SurveyCallback.fromNumber(star));
        },
        child: Container(
          height: 50,
          child: Icon(
            index > star ? Icons.star_border_rounded : Icons.star_rounded,
            size: widget.starSize,
            color: widget.starColor.withOpacity(index > star ? 0.4 : 1),
          ),
        ),
      ),
    );
  }
}
