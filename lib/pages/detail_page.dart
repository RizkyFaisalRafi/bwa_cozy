import 'package:bwa_cozy/models/facilities_model.dart';
import 'package:bwa_cozy/models/space_model.dart';
import 'package:bwa_cozy/pages/error_page.dart';
import 'package:bwa_cozy/theme.dart';
import 'package:bwa_cozy/widgets/facility_item.dart';
import 'package:bwa_cozy/widgets/rating_item.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final SpaceModel spaceModel;

  const DetailPage({super.key, required this.spaceModel});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isClicked = false;

  final String notFound =
      'https://img.freepik.com/free-vector/glitch-error-404-page-background_23-2148091215.jpg?w=740&t=st=1690599557~exp=1690600157~hmac=65da075bd98c16d5f77d2fe5f936876011296e64d137c328bc2c8cf7067257ee';

  @override
  Widget build(BuildContext context) {
    Future<void> launchMap() async {
      final Uri url = Uri.parse(widget.spaceModel.mapUrl as String);
      // final Uri mapsUrl = Uri(
      //   scheme: 'https',
      //   path: url,
      // );

      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ErrorPage(),
            ),
          );
        }
      }
    }

    void launchPhone() async {
      final Uri url = Uri(scheme: 'tel', path: widget.spaceModel.phone);

      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    Future<void> showConfirmation() async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Konfirmasi'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text('Apakah kamu ingin menghubungi pemilik kost?'),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Batal'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    launchPhone();
                  },
                  child: const Text('Hubungi'),
                ),
              ],
            );
          });
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Image.network(
              widget.spaceModel.imageUrl ?? notFound,
              // 'assets/images/thumbnail.png',
              width: MediaQuery.of(context).size.width,
              height: 340,
              fit: BoxFit.cover,
            ),
            ListView(
              children: [
                const SizedBox(
                  height: 328,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: SizedBox(
                          height: 30,
                        ),
                      ),

                      // NOTE: TITLE
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: edge,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.spaceModel.name ?? 'null',
                                  // 'Kuretakeso Hott',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: '\$${widget.spaceModel.price}',
                                    style: purpleTextStyle.copyWith(
                                      fontSize: 16,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '/ month',
                                        style: greyTextStyle.copyWith(
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [1, 2, 3, 4, 5].map((index) {
                                return Container(
                                  margin: const EdgeInsets.only(left: 2),
                                  child: RatingItem(
                                    index: index,
                                    rating: widget.spaceModel.rating ?? 0,
                                  ),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      // NOTE: MAIN FACILITIES
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text(
                          'Main Facilities',
                          style: regularTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FacilityItem(
                            facilitiesModel: FacilitiesModel(
                              id: 1,
                              imageUrl: 'assets/images/icon_kitchen.png',
                              total: widget.spaceModel.numberOfKitchens,
                              title: 'Kitchen',
                            ),
                          ),
                          FacilityItem(
                            facilitiesModel: FacilitiesModel(
                              id: 2,
                              imageUrl: 'assets/images/icon_bedroom.png',
                              total: widget.spaceModel.numberOfBedrooms,
                              title: 'Bedroom',
                            ),
                          ),
                          FacilityItem(
                            facilitiesModel: FacilitiesModel(
                              id: 3,
                              imageUrl: 'assets/images/icon_cupboard.png',
                              total: widget.spaceModel.numberOfCupboards,
                              title: 'Big Lemari',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      // NOTE: PHOTOS
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Text(
                          'Photos',
                          style: regularTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 88,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: widget.spaceModel.photos!.map((item) {
                              return Container(
                                margin: EdgeInsets.only(
                                  left: edge,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    item ?? notFound,
                                    width: 110,
                                    height: 88,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    (loadingProgress
                                                            .expectedTotalBytes ??
                                                        1)
                                                : null,
                                          ),
                                        );
                                      }
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.network(
                                        notFound,
                                        width: 110,
                                        height: 88,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                              );
                            }).toList()

                            // [
                            //   SizedBox(
                            //     width: edge,
                            //   ),
                            //   Image.asset(
                            //     'assets/images/photo1.png',
                            //     width: 110,
                            //     height: 88,
                            //     fit: BoxFit.cover,
                            //   ),
                            //   const SizedBox(
                            //     width: 18,
                            //   ),
                            //   Image.asset(
                            //     'assets/images/photo2.png',
                            //     width: 110,
                            //     height: 88,
                            //     fit: BoxFit.cover,
                            //   ),
                            //   const SizedBox(
                            //     width: 18,
                            //   ),
                            //   Image.asset(
                            //     'assets/images/photo3.png',
                            //     width: 110,
                            //     height: 88,
                            //     fit: BoxFit.cover,
                            //   ),
                            //   SizedBox(
                            //     width: edge,
                            //   ),
                            // ],

                            ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                // NOTE: LOCATION
                Padding(
                  padding: EdgeInsets.only(left: edge),
                  child: Text(
                    'Location',
                    style: regularTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: edge),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.spaceModel.address}\n${widget.spaceModel}',
                        style: greyTextStyle,
                      ),
                      InkWell(
                        onTap: () {
                          launchMap();
                        },
                        child: Image.asset(
                          'assets/images/btn_map.png',
                          width: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: edge),
                  height: 50,
                  width: MediaQuery.of(context).size.width - (2 * edge),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: purpleColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          17,
                        ),
                      ),
                    ),
                    onPressed: () {
                      showConfirmation();
                      // launchPhone();
                    },
                    child: Text(
                      'Book Now',
                      style: whiteTextStyle.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: edge, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/images/btn_back.png',
                      width: 40,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isClicked = !isClicked;
                      });
                    },
                    child: Image.asset(
                      isClicked
                          ? 'assets/images/btn_wishlist_filled.png'
                          : 'assets/images/btn_wishlist.png',
                      width: 40,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
