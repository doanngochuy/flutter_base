import 'package:flutter/material.dart';
import 'package:EMO/common/styles/styles.dart';

class SettingSwitcherWidget extends StatefulWidget {
  final bool? initialValue;
  final String title;
  final String? subtitle;
  final ValueChanged<bool> onChanged;

  const SettingSwitcherWidget({
    super.key,
    this.initialValue,
    required this.onChanged,
    required this.title,
    this.subtitle,
  });

  @override
  State<SettingSwitcherWidget> createState() => _SettingSwitcherWidgetState();
}

class _SettingSwitcherWidgetState extends State<SettingSwitcherWidget> {
  late bool _value;

  @override
  initState() {
    super.initState();
    _value = widget.initialValue ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        widget.title,
        style: TextStyles.title1.copyWith(
          fontWeight: FontWeight.w400,
        ),
      ),
      contentPadding: EdgeInsets.only(
        left: Insets.med,
        right: Insets.xs,
      ),
      activeColor: AppColor.primary,
      subtitle: widget.subtitle != null ? Text(widget.subtitle!) : null,
      value: _value,
      onChanged: (value) {
        _value = !_value;
        widget.onChanged(_value);
        setState(() {});
      },
    );
  }
}
