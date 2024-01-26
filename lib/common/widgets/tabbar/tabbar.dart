import 'package:flutter/material.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:EMO/common/values/values.dart';

class CustomTabBar extends StatefulWidget {
  final List<String> tabTitles;
  final EdgeInsetsGeometry? margin;
  final bool isScrollable;
  final EdgeInsetsGeometry? padding;
  final TabController? controller;

  const CustomTabBar({
    Key? key,
    required this.tabTitles,
    this.margin,
    this.isScrollable = false,
    this.padding,
    this.controller,
  }) : super(key: key);

  @override
  State<CustomTabBar> createState() => CustomTabBarState();
}

class CustomTabBarState extends State<CustomTabBar> {
  late TabController _controller;
  int _currentIndex = 0;

  @override
  void didChangeDependencies() {
    _controller = widget.controller ?? DefaultTabController.of(context);
    _controller.addListener(_onTabChanged);
    super.didChangeDependencies();
  }

  void _onTabChanged() {
    _currentIndex = _controller.index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kToolbarHeight,
      color: AppColor.white,
      padding: widget.margin,
      child: Container(
        key: Key(AppKey.$tabBarKey),
        decoration: BoxDecoration(
          color: AppColor.grey300,
          borderRadius: BorderRadius.circular(Insets.xl),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Insets.sm),
          child: TabBar(
            labelPadding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            tabs: widget.tabTitles.asMap().entries.map(
              (e) {
                final index = e.key;
                final title = e.value;

                return Tab(
                  child: Container(
                    decoration: BoxDecoration(
                      color: _currentIndex == index ? AppColor.blueLight : Colors.transparent,
                      borderRadius: BorderRadius.circular(Insets.xl),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: Insets.lg, vertical: Insets.xs + 1),
                    child: Text(
                      title.titleWithEllipsis(),
                      style: TextStyles.title1.copyWith(
                        fontWeight: _currentIndex == index ? FontWeight.bold : FontWeight.normal,
                        color: _currentIndex == index ? AppColor.white : AppColor.primaryText,
                        overflow: TextOverflow.ellipsis,
                        height: 0,
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
            indicatorColor: Colors.transparent,
            controller: _controller,
            isScrollable: widget.isScrollable,
            padding: widget.padding,
          ),
        ),
      ),
    );
  }
}
