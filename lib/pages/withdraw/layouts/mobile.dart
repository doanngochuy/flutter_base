import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/pages/create_withdraw/index.dart';
import 'package:EMO/pages/withdraw/index.dart';
import 'package:flutter/material.dart';

class WithdrawMobile extends StatelessWidget {
  const WithdrawMobile({Key? key}) : super(key: key);

  User get user => UserStore.to.user;

  void _createWithdraw(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreateWithdrawPage(),
      ),
    );
  }

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
        body: Container(
          color: AppColor.primaryBackgroundSuperLight,
          child: const TabBarView(
            children: <Widget>[
              WithdrawList(), //All status
              WithdrawList(statusFilter: WithdrawStatus.requested),
              WithdrawList(statusFilter: WithdrawStatus.transferred),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _createWithdraw(context),
          label: const Text('Rút tiền', style: TextStyle(color: AppColor.white)),
          icon: const Icon(Icons.arrow_circle_down_rounded, color: AppColor.white),
          backgroundColor: AppColor.successColor,
          elevation: 3,
          extendedIconLabelSpacing: Insets.sm,
          extendedPadding: EdgeInsets.only(left: Insets.med, right: Insets.lg),
        ),
      ),
    );
  }
}
