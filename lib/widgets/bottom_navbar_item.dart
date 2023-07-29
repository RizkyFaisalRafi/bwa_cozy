// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:bwa_cozy/theme.dart';

class BottomNavbarItem extends StatelessWidget {
  final String imageUrl;
  final bool isActive;

  const BottomNavbarItem({
    Key? key,
    required this.imageUrl,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          imageUrl,
          // 'assets/images/icon_home.png',
          width: 26,
          height: 26,
        ),
        const Spacer(),
        isActive
            ? Container(
                width: 30,
                height: 2,
                decoration: BoxDecoration(
                  color: purpleColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(1000),
                    bottom: Radius.circular(1000),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
