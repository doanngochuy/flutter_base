import 'package:flutter/material.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/utils/utils.dart';

import '../../../common/entities/entities.dart';

class ContentJob extends StatelessWidget {
  const ContentJob({Key? key, required this.job}) : super(key: key);
  final Job job;

  Widget _textItem(List<InlineSpan> texts) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: Insets.xs, horizontal: Insets.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Insets.med),
        side: const BorderSide(
          color: Colors.transparent,
          width: 0,
        ),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16.0, color: Colors.black),
          children: texts,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textItem([
            const TextSpan(text: 'Bước 1: Truy cập '),
            const TextSpan(
              text: 'Google.com',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ]),
          _textItem([
            const TextSpan(text: 'Bước 2: Nhập từ khoá '),
            TextSpan(
              text: job.keyWord,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ]),
          _textItem([
            const TextSpan(text: 'Bước 3: Tìm và truy cập trang web \n'),
            TextSpan(
              text: job.url,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ]),
          _textItem([
            const TextSpan(
                text: 'Bước 4: Kéo xuống dưới cùng trang web và đợi đồng hồ đếm ngược hết \n'),
            TextSpan(
              text: 'Thời gian chờ ${job.time} giây',
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ]),
          _textItem([
            const TextSpan(text: 'Bước 5: Hoàn thành nhận thưởng \n'),
            TextSpan(
              text: 'Tiền thưởng ${job.total.toCurrencyStr} đ',
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
