import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/pages/withdraw/index.dart';
import 'package:flutter/material.dart';

class WithdrawMobile extends StatelessWidget {
  const WithdrawMobile({Key? key}) : super(key: key);

  User get user => UserStore.to.user;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lịch sử rút tiền', style: TextStyle(color: Colors.white)),
          backgroundColor: AppColor.successColor,
          bottom: TabBar(
            unselectedLabelColor: AppColor.white.withOpacity(0.5),
            labelColor: AppColor.white,
            indicatorColor: AppColor.successColor,
            tabs: <Widget>[
              Tab(
                text: S.current.Tat_ca,
              ),
              Tab(
                text: S.current.Dang_cho,
              ),
              Tab(
                text: S.current.Hoan_thanh,
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            WithdrawList(),
            WithdrawList(status: WithdrawStatus.requested),
            WithdrawList(status: WithdrawStatus.transferred),
          ],
        ),
      ),
    );
  }
}
