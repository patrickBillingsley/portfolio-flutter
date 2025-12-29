import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class CaseStudy extends ChangeNotifier {
  final String fileName;

  CaseStudy({
    required this.fileName,
  }) {
    _load();
  }

  String? _content;
  String get content => _content ?? '';

  List<String> get sections {
    if (_content == null) return [];

    return RegExp(r'#+.*?(?=\n#|$)', dotAll: true).allMatches(content).map((m) => m.group(0)!).toList();
  }

  bool get isLoading => _content == null;

  Future<void> _load() async {
    if (_content?.isNotEmpty ?? false) {
      return;
    }

    _content = await rootBundle.loadString('assets/case_studies/$fileName.md');
    notifyListeners();
  }
}
