import 'package:flutter/material.dart';
import 'package:flutter_base/common/store/store.dart';
import 'package:flutter_base/common/styles/styles.dart';

import '../web_data_table.dart';

class WebDataTableHeaderWidget<T> extends StatefulWidget {
  const WebDataTableHeaderWidget({
    Key? key,
    required this.tableColumns,
    required this.onChangedBySort,
    this.width,
  }) : super(key: key);

  final List<WebDataTableColumn<T>> tableColumns;
  final SortDataVoid onChangedBySort;
  final double? width;

  @override
  WebDataTableHeaderWidgetState<T> createState() => WebDataTableHeaderWidgetState<T>();
}

class WebDataTableHeaderWidgetState<T> extends State<WebDataTableHeaderWidget<T>> {
  static final double defaultHeightHeader = 40 * ConfigStore.to.scale;

  String sortByKey = '';
  WebDataTableSortType typeSort = WebDataTableSortType.none;

  Widget btnHeader({
    required VoidCallback onPressed,
    required String text,
    required WebDataTableSortType statusSort,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        backgroundColor: AppColor.black800,
        foregroundColor: AppColor.grey300,
        padding: EdgeInsets.zero,
        elevation: 0,
        minimumSize: Size.zero,
        shadowColor: Colors.transparent,
      ),
      child: Container(
        width: double.infinity,
        height: defaultHeightHeader,
        decoration: const BoxDecoration(color: AppColor.black800),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyles.button1.copyWith(color: AppColor.white),
            ),
            if (statusSort != WebDataTableSortType.none)
              Positioned(
                right: Insets.xs,
                child: Icon(
                  statusSort == WebDataTableSortType.asc
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                  color: AppColor.grey600,
                  size: IconSizes.sm,
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget emptyColumn() => Container(
        width: widthWhenHaveShowMore(totalWidth: widget.width),
        height: defaultHeightHeader,
        padding: EdgeInsets.all(Insets.lg),
      );

  @override
  Widget build(BuildContext context) {
    final List<WebDataTableColumn<T>> tableColumnsForScreenWidth =
        getListColumnForScreenWith(widget.tableColumns);
    List<Widget> headers = [];
    for (int index = 0; index < tableColumnsForScreenWidth.length; index++) {
      if (tableColumnsForScreenWidth[index].key.isEmpty) {
        headers.add(emptyColumn());
      } else {
        headers.add(
          wrapItem(
            index: index,
            flex: tableColumnsForScreenWidth[index].flex,
            width: tableColumnsForScreenWidth[index].width,
            child: btnHeader(
              onPressed: () {
                if (sortByKey == tableColumnsForScreenWidth[index].key) {
                  typeSort = (typeSort == WebDataTableSortType.asc)
                      ? WebDataTableSortType.desc
                      : WebDataTableSortType.asc;
                } else {
                  sortByKey = tableColumnsForScreenWidth[index].key;
                  typeSort = WebDataTableSortType.asc;
                }

                widget.onChangedBySort.call(sortByKey, typeSort);
                setState(() {});
              },
              text: tableColumnsForScreenWidth[index].name,
              statusSort: sortByKey != tableColumnsForScreenWidth[index].key
                  ? WebDataTableSortType.none
                  : typeSort,
            ),
          ),
        );
      }
    }
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.black800,
        boxShadow: Shadows.universal,
      ),
      child: Row(
        children: headers,
      ),
    );
  }
}
