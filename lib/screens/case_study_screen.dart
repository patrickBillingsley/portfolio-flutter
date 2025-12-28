import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/mixins/navigation.dart';
import 'package:patrick_billingsley_portfolio/models/case_study.dart';
import 'package:patrick_billingsley_portfolio/widgets/loading_widget.dart';

class CaseStudyScreen extends StatefulWidget with Navigation {
  final CaseStudy caseStudy;

  const CaseStudyScreen(
    this.caseStudy, {
    super.key,
  });

  @override
  State<CaseStudyScreen> createState() => _CaseStudyScreenState();
}

class _CaseStudyScreenState extends State<CaseStudyScreen> {
  late final CaseStudy _caseStudy = widget.caseStudy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: LoadingWidget<String>(
          listenable: _caseStudy,
          value: _caseStudy.content,
          builder: (content) {
            return SingleChildScrollView(
              child: Text(content),
            );
          },
        ),
      ),
    );
  }
}
