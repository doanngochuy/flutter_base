import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

import '../../../common/entities/entities.dart';

class ContentJob extends StatelessWidget {
  const ContentJob({Key? key, required this.job}) : super(key: key);
  final Job job;

  Widget _textItem({
    required int index,
    required IconData iconData,
    required List<InlineSpan> texts,
  }) =>
      ListTile(
        leading: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Icon(
            iconData,
            color: Colors.white,
          ),
        ),
        title: Text('Bước $index', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 16.0, color: AppColor.grey600),
            children: texts,
          ),
        ),
        isThreeLine: false,
      );

  Widget get _divider => Padding(
    padding: const EdgeInsets.only(left: 56, right: 56),
    child: Divider(
      thickness: 1,
      color: AppColor.grey300WithOpacity500,
      height: 10,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 32, top: 32),
          child: Dash(
            direction: Axis.vertical,
            length: 350,
            dashLength: 20,
            dashColor: AppColor.primary,
          ),
        ),
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textItem(index: 1, iconData: Icons.web_stories, texts: [
            const TextSpan(text: 'Ấn nút  '),
            TextSpan(
              text: 'Bắt đầu làm ⬆',
              style: TextStyle(
                color: AppColor.primary.withOpacity(0.5),
              ),
            ),
          ]),
          _divider,
          _textItem(index: 2, iconData: Icons.keyboard, texts: [
            const TextSpan(text: 'Nhập từ khoá '),
            TextSpan(
              text: job.keyWord,
              style: TextStyle(
                color: AppColor.primary.withOpacity(0.7),
              ),
            ),
          ]),
          _divider,
          _textItem(index: 3, iconData: Icons.screen_search_desktop_rounded, texts: [
            const TextSpan(text: 'Tìm và truy cập trang web \n'),
            TextSpan(
              text: job.baseUrl,
              style: TextStyle(
                color: AppColor.primary.withOpacity(0.7),
              ),
            ),
          ]),
          _divider,
          _textItem(index: 4, iconData: Icons.access_time_filled, texts: [
            const TextSpan(text: 'Kéo xuống dưới cùng trang web và đợi đồng hồ đếm ngược hết \n'),
            TextSpan(
              text: 'Thời gian chờ ${job.time} giây',
              style: TextStyle(
                color: AppColor.primary.withOpacity(0.7),
              ),
            ),
          ]),
          _divider,
          _textItem(index: 5, iconData: Icons.cloud_done, texts: [
            const TextSpan(text: 'Hoàn thành nhận thưởng \n'),
            TextSpan(
              text: 'Tiền thưởng ${job.money.toCurrencyStr} đ',
              style: TextStyle(
                color: AppColor.primary.withOpacity(0.7),
              ),
            ),
          ]),
        ],
      ),
  ],
    );
  }
}
