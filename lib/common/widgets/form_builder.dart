import 'package:flutter/material.dart';
import 'package:flutter_base/common/utils/utils.dart';

Widget customContainer({
  required List<Widget> children,
  BoxBorder? border,
  BorderRadiusGeometry? borderRadius,
  EdgeInsets padding = const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
}) =>
    Container(
      margin: EdgeInsets.fromLTRB(10.scaleSize, 0, 10.scaleSize, 15.scaleSize),
      decoration: BoxDecoration(border: border, borderRadius: borderRadius, color: Colors.white),
      width: double.infinity,
      padding: padding,
      child: Column(
        children: children,
      ),
    );
