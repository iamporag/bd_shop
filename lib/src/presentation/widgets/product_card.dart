// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/assets_manager.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key,
      this.productThumbnail,
      required this.productTitle,
      this.productPrice,
      this.onItemTap,
      this.onItemDoubleTap});

  final String? productThumbnail;
  final String productTitle;
  final double? productPrice;
  final void Function()? onItemTap;
  final void Function()? onItemDoubleTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      splashColor: theme.colorScheme.background,
      onTap: onItemTap,
      onDoubleTap: onItemDoubleTap,
      child: Card(
        color: theme.colorScheme.background,
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
                aspectRatio: 3 / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl:
                        productThumbnail ?? AssetsManager.IMAGE_PLACE_HOLDER,
                    fit: BoxFit.cover,
                  ),
                ),),
                const Gap(5),
            Text(
              productTitle,
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onBackground,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(5),
            Text(
              '\$${productPrice?.toStringAsFixed(2)}',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onBackground,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
