import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../widgets/calc_button.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xff0d1117),
      body: SafeArea(
        child: Column(
          children: [
            // Display
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      calc.expression,
                      style: const TextStyle(fontSize: 28, color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      calc.result,
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            // Buttons Grid
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  buildRow(context, ["sin(", "cos(", "tan(", "√("]),
                  buildRow(context, ["ln(", "log(", "π", "e"]),
                  buildRow(context, ["7", "8", "9", "÷"]),
                  buildRow(context, ["4", "5", "6", "×"]),
                  buildRow(context, ["1", "2", "3", "-"]),
                  buildRow(context, ["0", ".", "C", "+"]),
                  Row(
                    children: [
                      Expanded(
                        child: CalcButton(
                          text: "DEL",
                          color: Colors.redAccent,
                          onTap: () => calc.delete(),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: CalcButton(
                          text: "=",
                          color: Colors.green,
                          onTap: () => calc.evaluate(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildRow(BuildContext context, List<String> buttons) {
    final calc = Provider.of<CalculatorProvider>(context, listen: false);

    return Row(
      children: buttons.map((b) {
        return Expanded(
          child: CalcButton(
            text: b,
            onTap: () {
              if (b == "C") {
                calc.clear();
              } else if (b == "π") {
                calc.add("3.141592");
              } else if (b == "e") {
                calc.add("2.718281");
              } else {
                calc.add(b);
              }
            },
          ),
        );
      }).toList(),
    );
  }
}
