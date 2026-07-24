import 'package:flutter/material.dart';
import '../../../core/widgets/cached_network_image.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 4.5,
      width: double.maxFinite,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CustomCachedImage(
          fit: BoxFit.cover,
          imageUrl:
              "https://www.volunteerworldnepal.org/wp-content/uploads/2024/10/celebration-of-the-dashain-festival.jpg",
          placeholder: PlaceholderThumbnail(),
        ),
      ),
    );
  }
}
