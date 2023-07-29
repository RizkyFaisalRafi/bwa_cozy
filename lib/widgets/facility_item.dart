import 'package:bwa_cozy/models/facilities_model.dart';
import 'package:bwa_cozy/theme.dart';
import 'package:flutter/material.dart';

class FacilityItem extends StatelessWidget {
  final FacilitiesModel facilitiesModel;
  const FacilityItem({
    super.key,
    required this.facilitiesModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          facilitiesModel.imageUrl ?? 'Null',
          width: 32,
        ),
        const SizedBox(
          height: 8,
        ),
        Text.rich(
          TextSpan(
            text: '${facilitiesModel.total}',
            style: purpleTextStyle,
            children: [
              TextSpan(
                text: ' ${facilitiesModel.title}',
                style: greyTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
