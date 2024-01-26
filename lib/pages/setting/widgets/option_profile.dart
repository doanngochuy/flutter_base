import 'package:EMO/common/styles/color.dart';
import 'package:flutter/material.dart';

Widget optionProfile(
    {required IconData icon,
    Color iconColor = AppColor.primary,
    required String name,
    required Function onTap,
    int? badge,
    int? badgeAdmin}) {
  return Column(
    children: [
      ListTile(
        onTap: () {
          onTap();
        },
        leading: Container(
          width: 38.0,
          height: 38.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: iconColor,
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            size: 28.0,
            color: iconColor,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                name,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            if (badge != null && badge != 0)
              Text(
                '($badge)',
                style: const TextStyle(color: Colors.green),
              ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
        trailing: const Icon(Icons.navigate_next_rounded),
      ),
      const Divider(
        height: 1,
      ),
    ],
  );
}
