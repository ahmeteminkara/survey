import 'package:flutter/material.dart';
import 'package:survey/survey.dart';

class SurveyEmoji extends StatefulWidget {
  final BuildContext context;
  final Function(SurveyCallback callback) onResult;
  final String question;

  final bool useCard;

  final Survey survey;
  final double iconSize;

  SurveyEmoji({
    @required this.context,
    @required this.onResult,
    this.question,
    this.useCard = false,
    this.iconSize = 50,
  }) : this.survey = Survey(
          context: context,
          question: question,
          useCard: useCard,
        );

  @override
  _SurveyEmojiState createState() => _SurveyEmojiState();
}

class Emoji {
  final IconData icon;
  final Color color;
  final int value;
  Emoji(this.icon, this.color, this.value);
}

class _SurveyEmojiState extends State<SurveyEmoji> {
  int selectedEmojiValue;

  @override
  Widget build(BuildContext context) {
    return widget.survey.build(_ui);
  }

  Widget get _ui => Container(
        child: Row(
          children: [
            Emoji(Icons.sentiment_satisfied_alt_rounded, Colors.green, 1),
            Emoji(Icons.sentiment_neutral, Colors.orange[300], 0),
            Emoji(Icons.sentiment_very_dissatisfied, Colors.red, -1),
          ].map((e) => emojiWidget(e)).toList(),
        ),
      );

  Widget emojiWidget(Emoji emoji) {
    bool isSelect = selectedEmojiValue == emoji.value;

    return IconButton(
      iconSize: widget.iconSize,
      onPressed: () {
        setState(() {
          selectedEmojiValue = emoji.value;
        });
        widget.onResult(SurveyCallback.fromNumber(emoji.value));
      },
      icon: Icon(emoji.icon, color: isSelect ? emoji.color : Colors.grey[300]),
    );
  }
}
