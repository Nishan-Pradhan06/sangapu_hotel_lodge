import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangapu/features/banners/blocs/get_banner/get_banner_bloc.dart';

import '../../../core/widgets/cached_network_image.dart';
import '../../../core/widgets/earnings_card_simmer.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetBannerBloc, GetBannerState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => CardShimmer(),
          failure: (failure) => Center(
            child: Text(
              "Failed to load banners.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          loaded: (banners) {
            if (banners.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 4.5,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: banners.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final banner = banners[index];

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CustomCachedImage(
                          imageUrl: banner.url,
                          fit: BoxFit.cover,
                          placeholder: PlaceholderThumbnail(),
                        ),
                      );
                    },
                  ),
                ),

                if (banners.length > 1) ...[
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      banners.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentIndex == index ? 24 : 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _currentIndex == index
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        );
      },
    );
  }
}
