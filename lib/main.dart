import 'package:flutter/material.dart';
import 'question_hub.dart';
import 'question.dart';

QuestionHub questionHub = QuestionHub();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: MainPage(),
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Icon> scoreList = [];

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = questionHub.getCorrectAnswer();

    setState(() {
      if (questionHub.isFinished() == true) {
        questionHub.reset();

        scoreList = [];
      } else {
        if (userAnswer == correctAnswer) {
          scoreList.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreList.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        questionHub.nextQuestion();
      }
    });
  }

  void dialogPopUp() {
    // flutter defined function
    String userEnteredQ;
    bool userEnteredA;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      onChanged: (text) {
                        userEnteredQ = text;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Your Question',
                      ),
                    ),
                    TextField(
                      onChanged: (text) {
                        if (text.toLowerCase() == 'true') {
                          userEnteredA = true;
                        } else if (text.toLowerCase() == 'false') {
                          userEnteredA = false;
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter The Answer in lowercase',
                      ),
                    ),
                    SizedBox(
                      width: 325.0,
                      child: RaisedButton(
                        onPressed: () {
                          questionHub.questionBank
                              .add(Question(userEnteredQ, userEnteredA));
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.lightBlue,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 325.0, top: 15.0),
          child: FloatingActionButton(
            child: Icon(
              Icons.add,
            ),
            onPressed: () {
              dialogPopUp();
            },
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionHub.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'TRUE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'FALSE',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreList,
        ),
      ],
    );
  }
}

/*
void dialogPopUp() {
  // flutter defined function

  TextEditingController customController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Text("Enter your Question"),
        content: TextField(
          controller: customController,
        ),
        content: TextField(controller: customController),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
*/
