import 'package:flutter/material.dart';

typedef CustomBuilder = Widget Function(VoidCallback setState);

class SettingBuilder extends StatefulWidget {
  final CustomBuilder builder;

  const SettingBuilder({
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  State<SettingBuilder> createState() => _SettingBuilderState();
}

class _SettingBuilderState extends State<SettingBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(
      () {
        setState(() {});
      },
    );
  }
}
