// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable

import 'package:calculator_advance/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double firstNum = 0.0;
  double secondNum = 0.0;

  var input = '';
  var output = '';

  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;

  onButtonClick(value) {
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        if (input == "+" || input == "-" || input == "*" || input == "/") {
          return;
        } else if (input == "+" ||
            input == "-" ||
            input == "*" ||
            input == "/") {
        } else {
          var userInput = input;
          userInput = input.replaceAll("x", "*");
          Parser p = Parser();
          Expression expression = p.parse(userInput);
          ContextModel cm = ContextModel();
          var finalValue = expression.evaluate(EvaluationType.REAL, cm);
          output = finalValue.toString();
          if (output.endsWith('.0')) {
            output = output.substring(0, output.length - 2);
          }
          input = output;
          hideInput = true;
          outputSize = 52;
        }
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hideInput ? '' : input,
                  style: TextStyle(color: Colors.white, fontSize: 48),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  output,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: outputSize),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )),
          Row(
            children: [
              button(
                  text: "AC",
                  tColor: orangeColor,
                  buttonbgColor: operatorColor),
              button(
                text: "<",
                buttonbgColor: operatorColor,
                tColor: orangeColor,
              ),
              button(
                text: "%",
                buttonbgColor: operatorColor,
                tColor: orangeColor,
              ),
              button(
                text: "/",
                buttonbgColor: operatorColor,
                tColor: orangeColor,
              ),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(
                text: "x",
                buttonbgColor: operatorColor,
                tColor: orangeColor,
              ),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(
                text: "-",
                buttonbgColor: operatorColor,
                tColor: orangeColor,
              ),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(
                text: "+",
                buttonbgColor: operatorColor,
                tColor: orangeColor,
              ),
            ],
          ),
          Row(
            children: [
              button(
                text: "00",
                buttonbgColor: operatorColor,
                tColor: orangeColor,
              ),
              button(text: "0"),
              button(text: "."),
              button(text: "=", buttonbgColor: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, tColor = Colors.white, buttonbgColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              primary: buttonbgColor,
              padding: EdgeInsets.all(22)),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: tColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
