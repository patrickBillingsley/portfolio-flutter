import 'dart:async';

import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/main.dart';
import 'package:patrick_billingsley_portfolio/widgets/random_text.dart';

class MatrixColumn extends StatefulWidget {
  const MatrixColumn({super.key});

  @override
  State<MatrixColumn> createState() => _MatrixColumnState();
}

class _MatrixColumnState extends State<MatrixColumn> {
  static const int _maxCharacterCount = 18;

  int _characterCount = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 80), (_) {
      setState(() {
        if (_characterCount > 80) {
          _characterCount = 0;
        }
        _characterCount++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter,
          stops: [0.0, 0.02, 0.1, 0.4, 0.9],
          colors: [
            CustomColors.matrixBlack,
            CustomColors.matrixGreen.shade600,
            CustomColors.matrixGreen.shade500,
            CustomColors.matrixGreen.shade400,
            CustomColors.matrixGreen.shade300,
          ],
        ).createShader(bounds);
      },
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: List.generate(_characterCount, (index) {
            return Opacity(
              opacity: index < _characterCount - _maxCharacterCount ? 0 : 1,
              child: RandomText(
                key: ValueKey(index),
              ),
            );
          }),
        ),
      ),
    );
  }
}

const List<String> characters = [
  // Hiragana (all 46 basic characters)
  'あ', 'い', 'う', 'え', 'お',
  'か', 'き', 'く', 'け', 'こ',
  'さ', 'し', 'す', 'せ', 'そ',
  'た', 'ち', 'つ', 'て', 'と',
  'な', 'に', 'ぬ', 'ね', 'の',
  'は', 'ひ', 'ふ', 'へ', 'ほ',
  'ま', 'み', 'む', 'め', 'も',
  'や', 'ゆ', 'よ',
  'ら', 'り', 'る', 'れ', 'ろ',
  'わ', 'を', 'ん',

  // Katakana (all 46 basic characters)
  'ア', 'イ', 'ウ', 'エ', 'オ',
  'カ', 'キ', 'ク', 'ケ', 'コ',
  'サ', 'シ', 'ス', 'セ', 'ソ',
  'タ', 'チ', 'ツ', 'テ', 'ト',
  'ナ', 'ニ', 'ヌ', 'ネ', 'ノ',
  'ハ', 'ヒ', 'フ', 'ヘ', 'ホ',
  'マ', 'ミ', 'ム', 'メ', 'モ',
  'ヤ', 'ユ', 'ヨ',
  'ラ', 'リ', 'ル', 'レ', 'ロ',
  'ワ', 'ヲ', 'ン',

  // Common Kanji (100+ characters)
  '日', '月', '火', '水', '木', '金', '土', '年', '時', '分',
  '一', '二', '三', '四', '五', '六', '七', '八', '九', '十',
  '百', '千', '万', '円', '人', '本', '出', '入', '上', '下',
  '中', '大', '小', '山', '川', '田', '林', '森', '空', '海',
  '天', '地', '雨', '雪', '雲', '風', '花', '草', '木', '竹',
  '石', '犬', '猫', '鳥', '魚', '虫', '目', '耳', '口', '手',
  '足', '体', '心', '力', '男', '女', '子', '学', '校', '先',
  '生', '文', '字', '言', '話', '読', '書', '見', '聞', '食',
  '飲', '休', '立', '歩', '走', '行', '来', '帰', '買', '売',
  '作', '使', '思', '考', '知', '分', '教', '会', '社', '業',
  '仕', '事', '物', '品', '店', '車', '電', '気', '道', '駅',
  '門', '家', '室', '今', '昔', '新', '古', '長', '短', '高',
  '低', '多', '少', '明', '暗', '強', '弱', '好', '悪', '正',
];
