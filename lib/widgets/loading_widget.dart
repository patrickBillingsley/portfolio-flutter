import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/models/case_study.dart';

class LoadingWidget extends StatelessWidget {
  final CaseStudy caseStudy;
  final Widget Function(CaseStudy) builder;

  const LoadingWidget({
    super.key,
    required this.caseStudy,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: caseStudy,
      builder: (_, _) {
        if (caseStudy.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return builder(caseStudy);
      },
    );
  }
}
