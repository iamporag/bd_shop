import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BrandCard extends StatelessWidget {
  final String brandTitle;
  final String brandLogo;
  const BrandCard(
      {super.key, required this.brandTitle, required this.brandLogo});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final layout = MediaQuery.of(context).size;
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 16.0, vertical: layout.width * 0.03),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.colorScheme.surfaceVariant),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: brandLogo,
          ),
          const Gap(7.0),
          Text(
            brandTitle,
            style: theme.textTheme.labelMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
