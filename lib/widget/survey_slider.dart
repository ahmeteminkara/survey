import 'package:flutter/material.dart';
import 'package:survey/survey.dart';

class SurveySlider extends StatefulWidget {
  final BuildContext context;
  final Function(SurveyCallback callback) onResult;
  final String question;

  final bool useCard;

  final Survey survey;
  final int min;
  final int max;
  final int step;
  final Color color;

  SurveySlider({
    @required this.context,
    @required this.onResult,
    this.question,
    this.useCard = false,
    @required this.max,
    Color color,
    this.min = 0,
    double step,
  })  : step = step != null ? step.toInt() : max.toInt(),
        color = color ?? const Color(0xFF0072ff),
        assert(min >= 0 && min < max),
        assert(step != null ? step <= max : true),
        this.survey = Survey(
          context: context,
          question: question,
          useCard: useCard,
        );

  @override
  _SurveySliderState createState() => _SurveySliderState();
}

class _SurveySliderState extends State<SurveySlider> {
  double paddingFactor = 0.2;
  double sliderHeight = 60;
  double sliderValue = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () => widget.onResult(SurveyCallback.fromNumber(sliderValue.toInt())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.survey.build(_ui);
  }

  Widget get _ui {
    return Container(
      width: sliderHeight * 5.5,
      height: sliderHeight,
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(
          Radius.circular((sliderHeight)),
        ),
        gradient: new LinearGradient(
            colors: [
              widget.color.withAlpha(150),
              widget.color,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 1.00),
            stops: [0.0, 0.7],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(sliderHeight * paddingFactor, 2, sliderHeight * paddingFactor, 2),
        child: Row(
          children: <Widget>[
            AnimatedOpacity(
              duration: Duration(milliseconds: 400),
              opacity: this.widget.min == sliderValue ? 0 : 1,
              child: Text(
                '${this.widget.min}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sliderHeight * .3,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: sliderHeight * .1),
            Expanded(
              child: Center(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white.withOpacity(1),
                    inactiveTrackColor: Colors.white.withOpacity(.5),
                    thumbColor: widget.color,
                    trackHeight: 4.0,
                    thumbShape: CustomSliderThumbCircle(
                      thumbRadius: sliderHeight * .4,
                      min: this.widget.min,
                      max: this.widget.max,
                    ),
                    overlayColor: Colors.white.withOpacity(.4),
                    //valueIndicatorColor: Colors.white,
                    activeTickMarkColor: Colors.white,
                    inactiveTickMarkColor: Colors.red.withOpacity(.7),
                  ),
                  child: Slider(
                      value: sliderValue,
                      onChanged: (value) {
                        setState(() {
                          sliderValue = value;
                        });
                        widget.onResult(SurveyCallback.fromNumber((sliderValue * 100).toInt()));
                      }),
                ),
              ),
            ),
            SizedBox(width: sliderHeight * .1),
            AnimatedOpacity(
              duration: Duration(milliseconds: 400),
              opacity: this.widget.max == (sliderValue * 100) ? 0 : 1,
              child: Text(
                '${this.widget.max}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sliderHeight * .3,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final int min;
  final int max;

  const CustomSliderThumbCircle({
    @required this.thumbRadius,
    this.min = 0,
    this.max = 10,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    double textScaleFactor,
    Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = Colors.white //Thumb Background Color
      ..style = PaintingStyle.fill;

    TextSpan span = new TextSpan(
      style: new TextStyle(
        fontSize: thumbRadius * .8,
        fontWeight: FontWeight.w700,
        color: sliderTheme.thumbColor, //Text Color of Value on Thumb
      ),
      text: getValue(value),
    );

    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter = Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawCircle(center, thumbRadius * .9, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return (min + (max - min) * value).round().toString();
  }
}
