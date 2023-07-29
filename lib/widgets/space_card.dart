import 'package:bwa_cozy/pages/detail_page.dart';
import 'package:flutter/material.dart';

import '../models/space_model.dart';
import '../theme.dart';

class SpaceCard extends StatelessWidget {
  final SpaceModel spaceModel;

  const SpaceCard({super.key, required this.spaceModel});
  final String notFound =
      'https://img.freepik.com/free-vector/glitch-error-404-page-background_23-2148091215.jpg?w=740&t=st=1690599557~exp=1690600157~hmac=65da075bd98c16d5f77d2fe5f936876011296e64d137c328bc2c8cf7067257ee';
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(spaceModel: spaceModel),
          ),
        );
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              width: 130,
              height: 110,
              child: Stack(
                children: [
                  Image.network(
                    spaceModel.imageUrl ?? notFound,
                    width: 130,
                    height: 110,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        notFound,
                        width: 130,
                        height: 110,
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 70,
                      height: 30,
                      decoration: BoxDecoration(
                        color: purpleColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/icon_star.png',
                            width: 16,
                            height: 16,
                          ),
                          Text(
                            '${spaceModel.rating}/5',
                            style: whiteTextStyle.copyWith(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                spaceModel.name ?? 'null',
                style: blackTextStyle.copyWith(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text.rich(
                TextSpan(
                  text: '\$${spaceModel.price}',
                  style: purpleTextStyle.copyWith(
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: '/ month',
                      style: greyTextStyle.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                '${spaceModel.city}, ${spaceModel.country}',
                style: greyTextStyle,
              )
            ],
          )
        ],
      ),
    );
  }
}
