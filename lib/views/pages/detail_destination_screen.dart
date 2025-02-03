import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/models/destination_model.dart';
import 'package:travel_app/shared/theme.dart';
import 'package:travel_app/views/widgets/custom_button.dart';
import 'package:travel_app/views/widgets/interest_item.dart';
import 'package:travel_app/views/widgets/mini_image_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailDestinationScreen extends StatefulWidget {
  final DestinationModel destination;

  DetailDestinationScreen({super.key, required this.destination});

  @override
  State<DetailDestinationScreen> createState() =>
      _DetailDestinationScreenState();
}

class _DetailDestinationScreenState extends State<DetailDestinationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: whiteColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 450,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        widget.destination.imageUrl,
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                width: double.infinity,
                height: 214,
                margin: EdgeInsets.only(top: 236),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    whiteColor.withValues(alpha: 0),
                    Colors.black.withValues(alpha: 0.95),
                  ],
                )),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
                child: Container(
                  margin: EdgeInsets.only(top: 256),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.destination.name,
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 24,
                                    fontWeight: semiBold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(widget.destination.country,
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: light,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Row(
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
                                    widget.destination.rating.toString(),
                                    style: whiteTextStyle.copyWith(
                                        fontSize: 14, fontWeight: semiBold),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('About',
                                style: primaryTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: semiBold,
                                )),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              widget.destination.about,
                              textAlign: TextAlign.justify,
                              style: primaryTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: regular,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text('Photos',
                                style: primaryTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: semiBold,
                                )),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              children:
                                  widget.destination.miniImageUrl.map((url) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: MiniImageWidget(miniImgUrl: url),
                                );
                              }).toList(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text('Interest',
                                style: primaryTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: semiBold,
                                )),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                InterestItem(
                                    title: widget.destination.interest1),
                                const SizedBox(
                                  width: 6,
                                ),
                                InterestItem(
                                    title: widget.destination.interest2),
                              ],
                            ),
                            Row(
                              children: [
                                InterestItem(
                                    title: widget.destination.interest3),
                                const SizedBox(
                                  width: 6,
                                ),
                                InterestItem(
                                    title: widget.destination.interest4),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'IDR ',
                                            decimalDigits: 0)
                                        .format(widget.destination.price),
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 18,
                                      fontWeight: semiBold,
                                    )),
                                Text('Per Orang',
                                    style: secondaryTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: medium,
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/seat',
                                        arguments: widget.destination);
                                  },
                                  child: CustomButton(title: 'Book Now')))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
