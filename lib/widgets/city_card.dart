import 'package:bwa_cozy/models/city_model.dart';
import 'package:bwa_cozy/theme.dart';
import 'package:flutter/material.dart';

class CityCard extends StatelessWidget {
  final CityModel cityModel;
  const CityCard({super.key, required this.cityModel});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 150,
        width: 120,
        color: const Color(0xffF6F7F8),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  cityModel.imageUrl ?? 'Null',
                  // 'assets/images/city1.png',
                  width: 120,
                  height: 102,
                  fit: BoxFit.cover,
                ),
                if (cityModel.isPopular == true)
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                        color: purpleColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/icon_star.png',
                          width: 22,
                          height: 22,
                        ),
                      ),
                    ),
                  )
                else
                  Container(),
              ],
            ),
            const SizedBox(
              height: 11,
            ),
            Text(
              cityModel.name ?? 'Null',
              style: blackTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
