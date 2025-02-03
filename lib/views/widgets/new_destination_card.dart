import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/models/destination_model.dart';
import 'package:travel_app/shared/theme.dart';

class NewDestinationCard extends StatelessWidget {
  final DestinationModel newDestination;

  const NewDestinationCard(
    this.newDestination, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: newDestination);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(newDestination.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  newDestination.name,
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  newDestination.country,
                  style: secondaryTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: regular,
                  ),
                )
              ],
            ),
            Spacer(
              flex: 1,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/star.png',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 5),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    newDestination.rating.toString(),
                    style: primaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: semiBold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
