import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/main.dart';
import 'package:patrick_billingsley_portfolio/mixins/navigation.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget with Navigation {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final Map<Field, TextEditingController> _controllers = {for (var field in Field.values) field: TextEditingController()};
  final Map<Field, FocusNode> _focusNodes = {for (var field in Field.values) field: FocusNode()};

  int _questionIndex = 0;

  bool get _isLastQuestion => _questionIndex + 1 >= Field.values.length;

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    for (final focus in _focusNodes.values) {
      focus.dispose();
    }
    super.dispose();
  }

  void _nextQuestion([_]) {
    if (_isLastQuestion) return;

    _setQuestion(_questionIndex + 1);
  }

  Future<void> _submit([_]) async {
    final url = Uri.parse('mailto:prbillingsley89@gmail.com').replace(
      queryParameters: {
        'subject': 'We have to talk!',
        'body': Field.values.map(_valueFor).join('\n'),
      },
    );

    await launchUrl(url);
  }

  void _setQuestion(int index) {
    setState(() {
      _questionIndex = index;
    });
  }

  String _valueFor(Field field) {
    return _controllers[field]?.text.trim() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _focusNodes.values.elementAt(_questionIndex).requestFocus,
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          minimum: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(_questionIndex + 1, (index) {
              final field = Field.values[index];

              return Row(
                children: [
                  Text('${field.question} '),
                  Expanded(
                    child: TextField(
                      onSubmitted: _isLastQuestion ? _submit : _nextQuestion,
                      controller: _controllers[field],
                      focusNode: _focusNodes[field],
                      autofocus: true,
                      cursorColor: CustomColors.matrixGreen,
                      cursorWidth: 12,
                      cursorHeight: 12,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

enum Field {
  email('What\'s your email?'),
  firstName('What\'s your first name?'),
  lastName('What\'s your last name?'),
  company('Who do you work with?'),
  number('What\'s your phone number?'),
  message('What would you like to tell me?');

  final String question;

  const Field(this.question);
}
