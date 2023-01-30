import 'package:flutter/material.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/theme/theme.dart';

class WebDataTable<T> extends StatefulWidget {
  const WebDataTable({
    Key? key,
    required this.tableColumns,
    required this.handleChangeData,
    required this.sortTableBy,
    required this.controller,
    this.width,
    this.showerMoreContentRowWidget,
    this.listItemsPerPage,
    this.topContent,
  }) : super(key: key);

  final List<WebDataTableColumn<T>> tableColumns;
  final WebDataTableController<T> controller;
  final Comparable Function(T object, String keyCol) sortTableBy;
  final AsyncDataGetter<T> handleChangeData;
  final ShowerMoreContentRowWidget<T>? showerMoreContentRowWidget;
  final List<int>? listItemsPerPage;
  final TopContentTable? topContent;
  final double? width;

  @override
  WebDataTableState<T> createState() => WebDataTableState<T>();
}

class WebDataTableState<T> extends State<WebDataTable<T>> {
  late WebDataTableController<T> _webDataTableController;

  @override
  void initState() {
    _webDataTableController = widget.controller;
    _webDataTableController.addListener(
      () {
        if (mounted) {
          setState(() {});
        }
      },
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant WebDataTable<T> oldWidget) {
    if (widget.controller != oldWidget.controller) {
      _webDataTableController = widget.controller;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final tableColumns = [...widget.tableColumns];
    if (widget.showerMoreContentRowWidget != null) {
      tableColumns.insert(
        0,
        WebDataTableColumn<T>(
          name: '',
          key: '',
          width: widthWhenHaveShowMore(totalWidth: widget.width),
        ),
      );
    }
    return Container(
      width: widget.width,
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal:
              BorderSide(color: AppColor.grey300, width: Strokes.thick / 2),
          vertical:
              BorderSide(color: AppColor.blueLight, width: Strokes.thick / 2),
        ),
        color: AppColor.white,
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                WebDataTableHeaderWidget<T>(
                  width: widget.width,
                  tableColumns: tableColumns,
                  onChangedBySort: (key, typeSort) {
                    _webDataTableController.sort((a, b) {
                      final aValue = widget.sortTableBy(a, key),
                          bValue = widget.sortTableBy(b, key);

                      switch (typeSort) {
                        case WebDataTableSortType.none:
                        case WebDataTableSortType.asc:
                          return Comparable.compare(aValue, bValue);
                        case WebDataTableSortType.desc:
                          return Comparable.compare(bValue, aValue);
                      }
                    });
                    setState(() {});
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: WebDataTableContentWidget<T>(
                      width: widget.width,
                      tableColumns: tableColumns,
                      controller: _webDataTableController,
                      showerMoreContentRowWidget:
                          widget.showerMoreContentRowWidget,
                      topContent: widget.topContent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          WebDataTablePagination(
            controller: _webDataTableController,
            listItemsPerPage: widget.listItemsPerPage,
            handleChangeData: (currentPage, itemsPerPage) =>
                Loading.openAndDismissLoading(
              () async {
                final data = await widget.handleChangeData(
                  top: itemsPerPage,
                  skip: itemsPerPage * (currentPage - 1),
                );

                _webDataTableController.setDataSources(data);
              },
            ),
          ),
        ],
      ),
    );
  }
}
