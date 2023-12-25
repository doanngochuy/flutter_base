import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  User get user => UserStore.to.user;

  late final TransactionController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(TransactionController());
    _controller.initData();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return Container(
          decoration: BoxDecoration(
            color: AppColor.primaryBackgroundSuperLight,
            border: const Border(
              right: BorderSide(
                color: AppColor.grey300,
              ),
            ),
          ),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxScrolled) => [
              SliverAppBar(
                expandedHeight: 180,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: context.width,
                          padding: const EdgeInsets.only(
                            right: 10,
                            top: 16,
                          ),
                          decoration: const BoxDecoration(
                            // gradient: LinearGradient(
                            //   colors: <Color>[AppColor.primary, AppColor.primaryLight],
                            // ),
                            color: AppColor.primary,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Xin chào, ${user.fullName}!",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          heightFactor: 1.5,
                          child: Obx(
                            () => TransactionHeaderWidget(
                              countItem: _controller.state.count,
                              totalMoney: _controller.state.totalMoney,
                              totalWithdraw: _controller.state.totalWithdraw,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  collapseMode: CollapseMode.parallax,
                ),
                backgroundColor: AppColor.primary,
                shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
                floating: true,
                pinned: true,
                snap: true,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
            body: const TransactionList(),
          ),
        );
      },
    );
  }
}
