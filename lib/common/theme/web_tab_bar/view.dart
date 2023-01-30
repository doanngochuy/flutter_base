import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/utils/utils.dart';

import '../spaces/spaces.dart';
import 'controller.dart';
import 'model.dart';

class WebTabBarWidget extends StatefulWidget {
  const WebTabBarWidget({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  final String title;
  final List<WebTabBarItem> items;

  @override
  State<WebTabBarWidget> createState() => _WebTabBarWidgetState();
}

class _WebTabBarWidgetState extends State<WebTabBarWidget> {
  final WebTabBarController controller = Get.put(WebTabBarController());

  @override
  void dispose() {
    controller.dispose();
    Get.delete<WebTabBarController>();
    super.dispose();
  }

  Icon tabBarIcon() {
    return Icon(
      controller.isHidden
          ? Icons.align_horizontal_right
          : Icons.align_horizontal_left,
      size: IconSizes.med,
      color: controller.isHidden ? AppColor.white : AppColor.black800,
    );
  }

  Widget buildWidgetsWhenOpenTab() {
    return Column(
      children: widget.items
          .map<Widget>(
            (element) => Container(
              margin: EdgeInsets.only(bottom: Insets.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        element.iconWhenHide,
                        size: IconSizes.med,
                        color: AppColor.black800,
                      ),
                      HSpace.xs,
                      Text(
                        element.title,
                        style: TextStyles.title2.copyWith(),
                      ),
                    ],
                  ),
                  VSpace.xs,
                  element.childWhenOpen,
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget buildWidgetsWhenHideTab() {
    return Column(
      children: widget.items
          .map<Widget>(
            (element) => Container(
              padding: EdgeInsets.symmetric(vertical: Insets.med),
              width: double.infinity,
              color:
                  element.isFiltering ? AppColor.blueLight : Colors.transparent,
              child: IconButton(
                onPressed: element.onTapWhenHide,
                padding: EdgeInsets.zero,
                icon: Icon(
                  element.iconWhenHide,
                  size: IconSizes.med,
                  color: AppColor.white,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Container(
          width: controller.isHidden ? 60.scaleSize : 240.scaleSize,
          height: context.height,
          decoration: BoxDecoration(
            color: controller.isHidden ? AppColor.black800 : AppColor.white,
          ),
          child: SingleChildScrollView(
            controller: ScrollController(),
            padding: controller.isHidden
                ? EdgeInsets.symmetric(
                    vertical: Insets.med,
                  )
                : EdgeInsets.all(
                    Insets.med,
                  ),
            child: controller.isHidden
                ? Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: Insets.med),
                        width: double.infinity,
                        color: Colors.transparent,
                        child: IconButton(
                          onPressed: controller.openTabBar,
                          icon: tabBarIcon(),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      buildWidgetsWhenHideTab(),
                    ],
                  )
                : Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.title,
                            style: TextStyles.title1,
                          ),
                          IconButton(
                            onPressed: controller.hiddenTabBar,
                            icon: tabBarIcon(),
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                            constraints: const BoxConstraints(
                              minWidth: 0,
                              minHeight: 0,
                            ),
                          )
                        ],
                      ),
                      VSpace.med,
                      buildWidgetsWhenOpenTab(),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
