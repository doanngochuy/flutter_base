import 'package:EMO/common/config/config.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:flutter/material.dart';

class WebDataTablePagination<T> extends StatefulWidget {
  const WebDataTablePagination({
    Key? key,
    required this.handleChangeData,
    required this.controller,
    this.listItemsPerPage,
  }) : super(key: key);

  final WebDataTableController<T> controller;
  final void Function(int currentPage, int itemsPerPage) handleChangeData;
  final List<int>? listItemsPerPage;

  @override
  State<WebDataTablePagination> createState() => _WebDataTablePaginationState();
}

class _WebDataTablePaginationState extends State<WebDataTablePagination> {
  /// style
  static final sizePageNumber = 30 * ConfigStore.to.scale;

  /// default
  static const int numberMore = 0;

  TablePaginationData get _tablePaginationData => widget.controller.paginationData;

  @override
  void initState() {
    _tablePaginationData.listItemsPerPage =
        widget.listItemsPerPage ?? _tablePaginationData.listItemsPerPage;
    _tablePaginationData.currentItemsPerPage = _tablePaginationData.listItemsPerPage[0];
    widget.controller.handleInitData();
    widget.controller.handleArrangeStartToEnd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.handleInitData();
    return LayoutBuilder(
      builder: (_, constrains) => Container(
        padding: EdgeInsets.symmetric(horizontal: Insets.med),
        width: double.infinity,
        decoration: BoxDecoration(color: AppColor.white, boxShadow: Shadows.universal),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: ConfigStore.to.screenWidth == ScreenWidth.DESKTOP
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  nextPageLeft(),
                  pageNumberWidget(),
                  nextPageRight(),
                  HSpace(Insets.lg),
                  dropdownItemsPerPage(),
                ],
              ),
            ),
            fromToItemsInPage(),
          ],
        ),
      ),
    );
  }

  Widget customIcon(IconData iconData) => Icon(
        iconData,
        size: IconSizes.xs,
        color: AppColor.grey600,
      );

  Widget nextPageRight() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: () {
            if (_tablePaginationData.currentPage < _tablePaginationData.pageNumber) {
              setState(
                () => _tablePaginationData.currentPage++,
              );
              widget.handleChangeData(
                _tablePaginationData.currentPage,
                _tablePaginationData.currentItemsPerPage,
              );
            }
          },
          icon: customIcon(CustomIcons.step_forward),
        ),
        IconButton(
          onPressed: () {
            setState(
              () => _tablePaginationData.currentPage = _tablePaginationData.pageNumber,
            );
            widget.handleChangeData(
              _tablePaginationData.currentPage,
              _tablePaginationData.currentItemsPerPage,
            );
          },
          icon: customIcon(CustomIcons.fast_forward),
        ),
      ],
    );
  }

  Widget nextPageLeft() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: () {
            setState(
              () => _tablePaginationData.currentPage = 1,
            );
            widget.handleChangeData(
              _tablePaginationData.currentPage,
              _tablePaginationData.currentItemsPerPage,
            );
          },
          icon: customIcon(CustomIcons.fast_backward),
        ),
        IconButton(
          onPressed: () {
            if (_tablePaginationData.currentPage > 1) {
              setState(
                () => _tablePaginationData.currentPage--,
              );
              widget.handleChangeData(
                _tablePaginationData.currentPage,
                _tablePaginationData.currentItemsPerPage,
              );
            }
          },
          icon: customIcon(CustomIcons.step_backward),
        ),
      ],
    );
  }

  Widget customBtnPageNumber({
    required int number,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Insets.xs),
      child: CustomButton.outline(
        height: sizePageNumber,
        width: sizePageNumber,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        text: number != 0 ? number.toString() : '...',
        textStyle: TextStyles.button1.copyWith(
          color: number == _tablePaginationData.currentPage ? AppColor.white : AppColor.grey600,
        ),
        borderWidth: number == _tablePaginationData.currentPage ? 0 : Strokes.thin,
        background:
            number == _tablePaginationData.currentPage ? AppColor.blueLight : AppColor.white,
      ),
    );
  }

  Widget pageNumberWidget() {
    widget.controller.handleArrangeStartToEnd();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_tablePaginationData.currentPage -
                _tablePaginationData.numberNextPage -
                _tablePaginationData.excessEnd -
                1 >
            0)
          customBtnPageNumber(
            onPressed: () {
              setState(
                () => _tablePaginationData.currentPage = _tablePaginationData.currentPage -
                    _tablePaginationData.numberNextPage -
                    _tablePaginationData.excessEnd -
                    1,
              );
              widget.handleChangeData(
                _tablePaginationData.currentPage,
                _tablePaginationData.currentItemsPerPage,
              );
            },
            number: numberMore,
          ),
        for (int number = _tablePaginationData.startPage;
            number < _tablePaginationData.endPage + 1;
            number++)
          customBtnPageNumber(
            onPressed: () {
              setState(() => _tablePaginationData.currentPage = number);
              widget.handleChangeData(
                _tablePaginationData.currentPage,
                _tablePaginationData.currentItemsPerPage,
              );
            },
            number: number,
          ),
        if (_tablePaginationData.currentPage +
                _tablePaginationData.numberNextPage +
                _tablePaginationData.excessStart <
            _tablePaginationData.pageNumber)
          customBtnPageNumber(
            onPressed: () {
              setState(
                () => _tablePaginationData.currentPage = _tablePaginationData.currentPage +
                    _tablePaginationData.numberNextPage +
                    _tablePaginationData.excessStart +
                    1,
              );
              widget.handleChangeData(
                _tablePaginationData.currentPage,
                _tablePaginationData.currentItemsPerPage,
              );
            },
            number: numberMore,
          )
      ],
    );
  }

  Widget dropdownItemsPerPage() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          customDropdownMenu(
            width: ConfigStore.to.scale * 96,
            height: ConfigStore.to.scale * 32,
            name: "per_page",
            label: "",
            onChanged: (dynamic value) {
              _tablePaginationData.currentPage = 1;
              if (value != 0) _tablePaginationData.currentItemsPerPage = value;

              _tablePaginationData.pageNumber = widget.controller.calculatePageNumber();
              widget.handleChangeData(
                _tablePaginationData.currentPage,
                _tablePaginationData.currentItemsPerPage,
              );
              setState(() {});
            },
            initialValue: _tablePaginationData.currentItemsPerPage,
            items: [
              dropdownItem(0, S.current.So_luong_phan_tu),
              ..._tablePaginationData.listItemsPerPage.map(
                (e) => dropdownItem(e, "$e"),
              ),
            ],
          ),
          HSpace(Insets.sm),
          Text(
            S.current.Phan_tu_mot_trang,
            style: TextStyles.body1.copyWith(color: AppColor.grey600),
          )
        ],
      );

  Widget fromToItemsInPage() {
    final fromItem =
        (_tablePaginationData.currentPage - 1) * _tablePaginationData.currentItemsPerPage;
    final toItem = _tablePaginationData.currentPage * _tablePaginationData.currentItemsPerPage;
    return ConfigStore.to.screenWidth.isDesktop
        ? Text(
            '$fromItem - ${toItem > widget.controller.itemCount ? widget.controller.itemCount : toItem} of ${widget.controller.itemCount} items',
            style: TextStyles.body1.copyWith(color: AppColor.grey600),
          )
        : const SizedBox.shrink();
  }
}
