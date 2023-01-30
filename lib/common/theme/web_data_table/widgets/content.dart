import 'package:flutter/material.dart';
import 'package:flutter_base/common/styles/styles.dart';

import '../web_data_table.dart';

class WebDataTableContentWidget<T> extends StatefulWidget {
  const WebDataTableContentWidget({
    Key? key,
    required this.tableColumns,
    required this.controller,
    this.width,
    this.showerMoreContentRowWidget,
    this.topContent,
  }) : super(key: key);

  final List<WebDataTableColumn<T>> tableColumns;
  final WebDataTableController<T> controller;
  final ShowerMoreContentRowWidget<T>? showerMoreContentRowWidget;
  final TopContentTable? topContent;
  final double? width;

  @override
  WebDataTableContentWidgetState<T> createState() => WebDataTableContentWidgetState<T>();
}

class WebDataTableContentWidgetState<T> extends State<WebDataTableContentWidget<T>> {
  int expandedDataIndex = -1;

  List<T> oldStateDataSource = [];

  Iterable<WebDataRowItemWidget<T>> _contents({
    required List<WebDataTableColumn<T>> tableColumnsForScreenWidth,
  }) {
    return widget.controller.dataSources.asMap().entries.map((entry) {
      int idx = entry.key;
      T rowData = entry.value;
      return WebDataRowItemWidget<T>(
        rowData: rowData,
        width: widget.width,
        isShowMore: isShowMore(idx),
        onPressed: () {
          setState(() {
            if (widget.showerMoreContentRowWidget != null) {
              expandedDataIndex = expandedDataIndex != idx ? idx : -1;
            }
          });
        },
        tableColumns: tableColumnsForScreenWidth,
        showerMoreContentRowWidget: widget.showerMoreContentRowWidget,
      );
    });
  }

  bool isChangeDataSource() {
    if (oldStateDataSource.isEmpty && widget.controller.dataSources.isEmpty) return false;
    if (oldStateDataSource.length != widget.controller.dataSources.length) return true;
    if (oldStateDataSource[0] != widget.controller.dataSources[0]) return true;
    return false;
  }

  bool isShowMore(int index) => expandedDataIndex == index;

  @override
  Widget build(BuildContext context) {
    if (isChangeDataSource()) {
      oldStateDataSource = [...widget.controller.dataSources];
      expandedDataIndex = -1;
    }
    final List<WebDataTableColumn<T>> tableColumnsForScreenWidth =
        getListColumnForScreenWith(widget.tableColumns);
    return Column(
      children: <Widget>[
        widget.topContent != null
            ? Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.5, color: AppColor.grey300),
                  ),
                ),
                child: widget.topContent!(tableColumnsForScreenWidth),
              )
            : const SizedBox.shrink(),
        ..._contents(
          tableColumnsForScreenWidth: tableColumnsForScreenWidth,
        ),
      ],
    );
  }
}
