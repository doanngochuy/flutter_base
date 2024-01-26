import 'package:flutter/material.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/utils/utils.dart';

import '../web_data_table.dart';

class WebDataRowItemWidget<T> extends StatelessWidget {
  const WebDataRowItemWidget({
    Key? key,
    required this.rowData,
    required this.tableColumns,
    this.width,
    this.isShowMore = false,
    this.showerMoreContentRowWidget,
    this.onPressed,
  }) : super(key: key);

  final T rowData;
  final bool isShowMore;
  final VoidCallback? onPressed;
  final List<WebDataTableColumn<T>> tableColumns;
  final double? width;
  final ShowerMoreContentRowWidget<T>? showerMoreContentRowWidget;

  Widget wrapContent({required Widget child}) => Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: Strokes.thin, color: AppColor.grey300),
          ),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            backgroundColor: Colors.transparent,
            foregroundColor: AppColor.grey300,
            padding: EdgeInsets.zero,
            shadowColor: Colors.transparent,
            elevation: 0,
            minimumSize: Size.zero,
          ),
          child: child,
        ),
      );

  Widget wrapShowMore({required Widget child}) => Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: Strokes.thin, color: AppColor.grey300),
          ),
        ),
        child: child,
      );

  Widget contentRowItem({required dynamic value, required T rowData}) => Padding(
        padding: EdgeInsets.symmetric(vertical: Insets.med, horizontal: Insets.xs),
        child: Text(value.toString(), style: TextStyles.body1.copyWith(color: AppColor.black800)),
      );

  Widget iconShowMore() => Icon(
        isShowMore ? CustomIcons.caret_down : CustomIcons.caret_right,
        size: IconSizes.sm,
        color: AppColor.black800,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        wrapContent(
          child: Row(
            children: tableColumns
                .map<Widget>(
                  (column) => wrapItemWithOutBorder(
                    flex: column.flex,
                    width: column.key.isEmpty
                        ? widthWhenHaveShowMore(totalWidth: width)
                        : column.width,
                    child: column.key.isEmpty
                        ? iconShowMore()
                        : column.customizeItemWidget == null
                            ? contentRowItem(
                                value: (rowData as dynamic).toJson()[column.name],
                                rowData: rowData,
                              )
                            : column.customizeItemWidget!(
                                (rowData as dynamic).toJson()[column.key],
                                rowData,
                                column.key,
                                column.name,
                                column.width,
                                column.showOnScreens,
                              ),
                  ),
                )
                .toList(),
          ),
        ),
        if (isShowMore)
          wrapShowMore(
            child: showerMoreContentRowWidget!(rowData),
          )
      ],
    );
  }
}
