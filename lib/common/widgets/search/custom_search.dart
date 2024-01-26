import 'package:flutter/material.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/service/service.dart';
import 'package:EMO/common/styles/styles.dart';

class CustomSearchWidget extends StatefulWidget {
  final String? hintText;

  const CustomSearchWidget({
    Key? key,
    this.hintText,
  }) : super(key: key);

  @override
  State<CustomSearchWidget> createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {
  bool _isSearching = false;
  final _searchController = TextEditingController();

  void clearSearch() {
    _searchController.clear();
    _isSearching = false;
    SearchStream.to.add('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: _searchController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: Corners.lgBorder,
            borderSide: BorderSide(color: AppColor.grey600),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          hintText: widget.hintText ?? S.current.Nhap_tu_khoa_tim_kiem,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _isSearching
              ? IconButton(icon: const Icon(Icons.clear), onPressed: clearSearch)
              : null,
        ),
        onChanged: (value) {
          setState(() => _isSearching = value.isNotEmpty);
          SearchStream.to.add(value);
        },
      ),
    );
  }
}
