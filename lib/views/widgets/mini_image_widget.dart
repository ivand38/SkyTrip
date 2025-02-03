import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/shared/theme.dart';

class MiniImageWidget extends StatelessWidget {
  final String miniImgUrl;

  MiniImageWidget({super.key, required this.miniImgUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: CachedNetworkImage(
        imageUrl: miniImgUrl,
        placeholder: (context, url) => CircularProgressIndicator(
          color: primaryColor,
          strokeWidth: 2,
        ),
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      ),
    );
  }
}
