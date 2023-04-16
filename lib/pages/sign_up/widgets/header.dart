import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/values/values.dart';
import 'package:flutter/material.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({Key? key}) : super(key: key);

  Widget _landscapeUI(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset(
            AppImages.$appIcon,
            width: 240 * ConfigStore.to.scale,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _landscapeUI(context);
  }
}
