import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/mixins/navigation.dart';
import 'package:patrick_billingsley_portfolio/models/case_study.dart';
import 'package:patrick_billingsley_portfolio/widgets/loading_widget.dart';

class CaseStudyScreen extends StatelessWidget with Navigation {
  final CaseStudy caseStudy;

  const CaseStudyScreen(
    this.caseStudy, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: LoadingWidget(
          caseStudy: caseStudy,
          builder: (caseStudy) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ...caseStudy.sections.map((section) {
                    return Text(section);
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
