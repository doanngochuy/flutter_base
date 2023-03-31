import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/pages/job_done/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobDoneMobile extends StatelessWidget {
  JobDoneMobile({Key? key}) : super(key: key);

  final JobDoneController _controller = JobDoneController.to;

  User get user => UserStore.to.user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.grey300WithOpacity500,
        border: const Border(
          right: BorderSide(
            color: AppColor.grey300,
          ),
        ),
      ),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxScrolled) => [
          SliverAppBar(
            expandedHeight: 180.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColor.successColor, AppColor.successColor.withOpacity(0)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Xin chào, ${user.fullName}!",
                      style: const TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Obx(
                      () => JobListHeaderWidget(
                        countItem: _controller.state.count,
                        totalMoney: _controller.state.totalMoney,
                      ),
                    ),
                  ],
                ),
              ),
              collapseMode: CollapseMode.parallax,
            ),
            backgroundColor: AppColor.successColor,
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
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {},
              ),
            ],
          ),
        ],
        body: const JobList(),
      ),
    );
  }
}
