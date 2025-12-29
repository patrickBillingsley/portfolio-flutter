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
  final PageController _controller = PageController();

  int _index = 0;

  void Function()? _next() {
    if (_index + 1 >= widget.caseStudy.sections.length) {
      return null;
    }

    return () {
      setState(() {
        _index++;
      });
      _controller.animateToPage(
        _index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    };
  }

  void Function()? _back() {
    if (_index <= 0) {
      return null;
    }

    return () {
      setState(() {
        _index--;
      });
      _controller.animateToPage(
        _index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: _controller,
                itemCount: widget.caseStudy.sections.length,
                itemBuilder: (context, index) {
                  final section = widget.caseStudy.sections[index];

                  return LoadingWidget(
                    caseStudy: widget.caseStudy,
                    builder: (caseStudy) {
                      return Center(
                        child: Text(section),
                      );
                    },
                  );
                },
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  FilledButton(
                    onPressed: _back(),
                    child: Text('Back'),
                  ),
                  FilledButton(
                    onPressed: _next(),
                    child: Text('Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
