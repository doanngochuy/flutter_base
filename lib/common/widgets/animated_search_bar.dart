import 'package:flutter/material.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/theme/inputs/inputs.dart';
import 'package:EMO/common/utils/utils.dart';

class AnimatedSearchBar extends StatefulWidget {
  const AnimatedSearchBar(
      {Key? key,
      this.controller,
      required this.hintText,
      required this.placeholderText,
      this.onChanged,
      this.onClear})
      : super(key: key);
  final TextEditingController? controller;
  final String hintText;
  final String placeholderText;
  final Function? onClear;
  final ValueChanged<String?>? onChanged;

  @override
  State<AnimatedSearchBar> createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  bool _folded = true;
  FocusNode searchFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    searchFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_folded) {
      searchFocusNode.requestFocus();
    }
    return Flexible(
      child: SizedBox(
        height: 56.scaleSize,
        width: double.infinity,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: AnimatedOpacity(
                opacity: _folded ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: Text(
                  widget.placeholderText,
                  style: TextStyles.title1.copyWith(
                    color: AppColor.black800,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: !_folded
                            ? CustomInput.outline(
                                focusNode: searchFocusNode,
                                controller: widget.controller,
                                padding: EdgeInsets.symmetric(horizontal: Insets.med, vertical: 0),
                                hintText: widget.hintText,
                                textAlign: TextAlign.start,
                                textStyle: TextStyles.title1.copyWith(
                                  color: AppColor.black800,
                                  fontWeight: FontWeight.w500,
                                ),
                                hintTextStyle: TextStyles.title1.copyWith(
                                  color: AppColor.grey600,
                                  fontWeight: FontWeight.w500,
                                ),
                                colorBorderFocus: AppColor.blueLight,
                                action: TextInputAction.done,
                                onChanged: widget.onChanged,
                              )
                            : null,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      child: IconButton(
                        onPressed: () {
                          if (widget.onClear != null && !_folded) {
                            widget.onClear!();
                          }
                          setState(() {
                            _folded = !_folded;
                          });
                        },
                        icon: Icon(
                          _folded ? CustomIcons.search : CustomIcons.times,
                          color: AppColor.black800,
                          size: IconSizes.sm,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
