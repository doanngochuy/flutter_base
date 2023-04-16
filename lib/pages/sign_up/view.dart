import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'controller.dart';
import 'widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  void initState() {
    super.initState();
    Get.put(SignUpController());
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<SignUpController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.grey100,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColor.black800,
          ),
          onPressed: context.pop,
        ),
      ),
      backgroundColor: AppColor.grey100,
      body: LayoutBuilder(
        builder: (context, constrains) {
          return InkWell(
            highlightColor: Colors.transparent,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Insets.lg,
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          const SignUpHeader(),
                          VSpace.lg,
                          const SignUpForm(),
                          VSpace.lg,
                          SignUpButtonsAction(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
