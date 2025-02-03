import 'package:flutter/material.dart';
import 'package:travel_app/models/destination_model.dart';
import 'package:travel_app/shared/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomBigCard extends StatelessWidget {
  final DestinationModel destination;

  const CustomBigCard(
    this.destination, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: destination);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 180,
            height: 210,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(destination.imageUrl),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(18)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                    width: 55,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(18),
                        )),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/star.png',
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 5),
                        Container(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            destination.rating.toString(),
                            style: primaryTextStyle.copyWith(
                                fontSize: 12, fontWeight: semiBold),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(destination.name,
              style: primaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: semiBold)),
          const SizedBox(height: 5),
          Text(destination.country,
              style: secondaryTextStyle.copyWith(
                  fontSize: 12, fontWeight: regular)),
        ]),
      ),
    );
  }
}
