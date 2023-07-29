import 'package:bwa_cozy/models/tips_card_model.dart';
import 'package:bwa_cozy/theme.dart';
import 'package:flutter/material.dart';

class TipsCard extends StatelessWidget {
  final TipsCardModel tipsCardModel;
  const TipsCard({super.key, required this.tipsCardModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          tipsCardModel.imageUrl ?? 'null',
          width: 80,
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tipsCardModel.title ?? 'null',
              style: blackTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'Updated ${tipsCardModel.updatedAt ?? 'null'}',
              style: greyTextStyle,
            ),
          ],
        ),
        const Spacer(), // Spacer untuk memberikan space agar ke pojok
        Icon(
          Icons.chevron_right_rounded,
          color: greyColor,
        ),
      ],
    );
  }
}
