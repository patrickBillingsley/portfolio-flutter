import 'package:flutter/material.dart';

class LoadingWidget<T extends Object> extends StatelessWidget {
  final ChangeNotifier listenable;
  final T? value;
  final Widget Function(T) builder;

  const LoadingWidget({
    super.key,
    required this.listenable,
    required this.value,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: listenable,
      builder: (context, child) {
        if (value == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return builder(value!);
      },
    );
  }
}
