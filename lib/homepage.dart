import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = "";
  var userAsware = "";
  final List<String> buttons = [
    "c",
    "DEL",
    "%",
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "ANS",
    "=",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SingleChildScrollView(
            child: Expanded(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 80),
                  Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        userQuestion,
                        style:
                            const TextStyle(fontSize: 35, color: Colors.white),
                      )),
                  Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        userAsware,
                        style:
                            const TextStyle(fontSize: 35, color: Colors.white),
                      )),
                ],
              ),
            )),
          ),
          Divider(
            color: Colors.grey[500],
            height: 10,
          ),
          Expanded(
              flex: 2,
              child: Container(
                  child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  // Clear Button
                  if (index == 0) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = " ";
                          userAsware = " ";
                        });
                      },
                      buttonText: buttons[index],
                      color: const Color.fromARGB(255, 125, 242, 129),
                      textcolor: Colors.white,
                    );
                  }
                  // Delete Button
                  else if (index == 1) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = userQuestion.substring(
                              0, userQuestion.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                      color: const Color.fromARGB(255, 238, 110, 101),
                      textcolor: Colors.white,
                    );
                  }
                  // equal Button
                  else if (index == buttons.length - 1) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          equlepressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.grey,
                      textcolor: Colors.white,
                    );
                  }
                  // Rest of the Buttons
                  else {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Colors.grey
                          : Colors.grey[800],
                      textcolor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.white,
                    );
                  }
                },
              )))
        ],
      ),
    );
  }

  bool isOperator(String L) {
    if (L == "%" || L == "/" || L == "-" || L == "+" || L == "x" || L == "=") {
      return true;
    }
    return false;
  }

  void equlepressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll("x", "*");
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAsware = eval.toString();
  }
}
