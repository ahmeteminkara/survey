import 'package:flutter/material.dart';
import 'package:survey/survey.dart';

import 'survey_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> list = List();

  @override
  void initState() {
    super.initState();

    list.add(_survey);
    list.add(_singleSelect);
    list.add(_multipleSelect);
    list.add(_trueFalse);
    list.add(_star);
    list.add(_emoji);
    list.add(_slider);

    list.add(ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        FlatButton(
            child: Text("Show Survey List in Stepper"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SurveyList(),
                  ));
            })
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Survey - Anket"), centerTitle: true),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: list.reversed.toList().map((e) => e).toList(),
      ),
    );
  }

  get _survey {
    return SurveyClassic(
      useCard: true,
      context: context,
      question: "Uygulama hakkında ne düşünüyorsunuz ?",
      placeHolder: "Değerlendirmenizi yazınız...",
      onResult: (SurveyCallback callback) => print(callback.text),
    );
  }

  get _singleSelect {
    return SurveySingleSelect(
      useCard: true,
      context: context,
      question: "Proje yönetiminde hangi departmanda görev almaktasınız ?",
      options: ["Yazılım Geliştirme", "Yazılım Destek", "Teknik Destek"],
      onResult: (SurveyCallback callback) => print(callback.text),
    );
  }

  get _multipleSelect {
    return SurveyMultipleSelect(
      useCard: true,
      context: context,
      question: "Hobileriniz nelerdir ?",
      options: ["Spor yapmak", "Müzik dinlemek", "Kitap okumak"],
      onResult: (SurveyCallback callback) => print(callback.textList),
    );
  }

  get _trueFalse {
    return SurveyTrueFalse(
      useCard: true,
      context: context,
      question: "Daha önce bu uygulamayı kullandınız mı ?",
      titlePositive: "Evet",
      titleNegative: "Hayır",
      onResult: (SurveyCallback callback) => print("Status: ${callback.status}"),
    );
  }

  get _star {
    return SurveyStars(
      useCard: true,
      context: context,
      question: "Puanınızı belirtmek ister miydiniz ?",
      onResult: (SurveyCallback callback) => print("Star: ${callback.number}"),
    );
  }

  get _emoji {
    return SurveyEmoji(
      useCard: true,
      context: context,
      question: "Bugün kendinizi nasıl hissediyorsunuz ?",
      onResult: (SurveyCallback callback) {
        print("emoji: ${callback.number}");
      },
    );
  }

  get _slider {
    return SurveySlider(
      useCard: true,
      context: context,
      question: "Derecelendirme yapmak ister misiniz ?",
      color: Colors.red,
      max: 100,
      onResult: (SurveyCallback callback) {
        print("slider: ${callback.number}");
      },
    );
  }
}
