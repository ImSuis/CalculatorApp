import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final TextEditingController _textController = TextEditingController();

  List<String> buttonText = [
    'C',
    '*',
    '/',
    '<-',
    '1',
    '2',
    '3',
    '+',
    '4',
    '5',
    '6',
    '-',
    '7',
    '8',
    '9',
    '*',
    '%',
    '0',
    '.',
    '=',
  ];

  int num1 = 0;
  int num2 = 0;
  String operator = '';

  void _calculate(String value) {
    try {
      int selectedNumber = operator == '' ? num1 : num2;
      selectedNumber = int.parse('$selectedNumber$value');
      operator == '' ? num1 = selectedNumber : num2 = selectedNumber;
      _textController.text = selectedNumber.toString();
    } catch (e) {
      switch (value) {
        case 'C':
          {
            _textController.text = '';
            num1 = 0;
            num2 = 0;
            operator = '';
            break; // Add break statement here
          }
        case '+':
          {
            _textController.text = operator == '' ? '$num1+' : '';
            operator = 'Add';
            break;
          }
        case '-':
          {
            _textController.text = operator == '' ? '$num1-' : '';
            operator = 'Subtract';
            break;
          }
        case '*':
          {
            _textController.text = operator == '' ? '$num1*' : '';
            operator = 'Multiply';
            break;
          }
        case '/':
          {
            _textController.text = operator == '' ? '$num1/' : '';
            operator = 'Divide';
            break;
          }
        case '=':
          {
            switch (operator) {
              case ('Add'):
                _textController.text = '${num1 + num2}';
                break;
              case ('Subtract'):
                _textController.text = '${num1 - num2}';
                break;
              case ('Multiply'):
                _textController.text = '${num1 * num2}';
                break;
              case ('Divide'):
                _textController.text = '${num1 / num2}';
                break;
            }
            break;
          }
        case '<-':
          {
            String currentText = _textController.text;
            if (currentText.isNotEmpty) {
              _textController.text =
                  currentText.substring(0, currentText.length - 1);
            }
            break;
          }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(
            fontFamily: 'InknutAntiqua',
            fontSize: 28,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: _textController,
              textAlign: TextAlign.end,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.74,
                children: [
                  for (int i = 0; i < buttonText.length; i++) ...{
                    ClipOval(
                      child: ElevatedButton(
                        onPressed: () {
                          _calculate(buttonText[i]);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(20),
                            backgroundColor:
                                const Color.fromARGB(255, 210, 217, 222)),
                        child: Text(
                          buttonText[i],
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  }
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
