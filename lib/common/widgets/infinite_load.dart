import 'package:flutter/material.dart';
import 'package:EMO/common/styles/styles.dart';

@Deprecated(
  "It will delete in the future",
)
Widget infinityLoading() {
  return Center(
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColor.blueLight),
      ),
    ),
  );
}
