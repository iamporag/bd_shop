// ignore_for_file: deprecated_member_use

import 'package:bd_shop/src/presentation/widgets/full_width_button.dart';
import 'package:bd_shop/src/routes/routes.dart';
import 'package:bd_shop/src/utils/assets_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';

import '../../../blocs/blocs.dart';
import '../../../data/model/models.dart';
import '../../widgets/productVariant_categoryItem.dart';
import '../../widgets/product_review_card.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final layout = MediaQuery.of(context).size;
    return PopScope(
      onPopInvoked: (didPop) {
        context.read<ProductBloc>().add(FetchProduct());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.background,
          surfaceTintColor: theme.colorScheme.background,
          leading: IconButton.filled(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(theme.colorScheme.surfaceVariant),
            ),
            onPressed: () {
              context.read<ProductBloc>().add(FetchProduct());
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          actions: [
            IconButton.filled(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(theme.colorScheme.surfaceVariant),
              ),
              onPressed: () => context.pop(),
              icon: SvgPicture.asset(
                AssetsManager.CART_BAG,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoadSuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 3 / 3,
                      child: CachedNetworkImage(
                        imageUrl: state.product.imageGallery?.first.url ??
                            AssetsManager.IMAGE_PLACE_HOLDER,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ListTile(
                      title: BlocBuilder<CategoryBloc, CategoryState>(
                        builder: (context, state) => Text(
                          state is CategoryFetchSuccess
                              ? state.category.title ?? ''
                              : 'No Category Found',
                        ),
                      ),
                      titleTextStyle: theme.textTheme.labelSmall
                          ?.copyWith(color: theme.colorScheme.outline),
                      subtitle: Text(state.product.productTitle ?? ''),
                      subtitleTextStyle: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Price',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.outline,
                              )),
                          Text(
                            '\$${state.product.productPrice!.toStringAsFixed(2)}',
                            style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.onBackground,
                                fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                    ),
                    _buildProductImageGallery(
                        layout.width * 0.2, state.product.imageGallery),
                    _buildProductVariantGalley(state.product.varient),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Description',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onBackground,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          ReadMoreText(
                            state.product.productDetails ??
                                'No Description Found',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.outline,
                            ),
                            textAlign: TextAlign.justify,
                            trimMode: TrimMode.Line,
                            trimLines: 5,
                            moreStyle: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.tertiary,
                              fontWeight: FontWeight.bold,
                            ),
                            lessStyle: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.tertiary,
                              fontWeight: FontWeight.bold,
                            ),
                            trimCollapsedText: 'Show More',
                            trimExpandedText: 'Show Less',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Review',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onBackground,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'View All',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<RatingBloc, RatingState>(
                      builder: (context, state) => Column(
                        children: state is ReviewLoadSuccess
                            ? List.generate(
                                state.reviews.length,
                                (index) => ProductReviewCard(
                                  imageUrl: state.reviews[index].userProfilePic,
                                  name: state.reviews[index].userName,
                                  date: DateFormat(DateFormat.YEAR_MONTH_DAY)
                                      .format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              state.reviews[index].createdAt
                                                  .millisecondsSinceEpoch)),
                                  ratingPoint: state.reviews[index].rating,
                                  review: state.reviews[index].review,
                                ),
                              )
                            : [Text("No data Found")],
                      ),
                    ),
                    Gap(10.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<RatingBloc>()
                                  .add(RequestAddReview());
                              final id = state.product.productId;
                              context.pushNamed(Routes.ADD_REVIEW_ROUTE,
                                  extra: {'id': id});
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  theme.colorScheme.tertiary),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Write Review",
                                  style: theme.textTheme.labelMedium?.copyWith(
                                      color: theme.colorScheme.onTertiary),
                                ),
                                const Gap(8),
                                SvgPicture.asset(AssetsManager.EDIT_PAN_ICON)
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else if (state is ProductFailed) {
                return Column(
                  children: [
                    LottieBuilder.asset(AssetsManager.ERROR_ANIMATION),
                    const Gap(20),
                    Text(
                      state.message,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    )
                  ],
                );
              } else {
                return const Column();
              }
            },
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              tileColor: theme.colorScheme.surfaceVariant,
              title: Text(
                'Total Price',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                'with VAT, SD ',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.outline,
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  final double vat = state is ProductLoadSuccess
                      ? state.product.vatSd ?? 0.0
                      : 0.0;
                  debugPrint('Vat $vat');
                  final double price = state is ProductLoadSuccess
                      ? state.product.productPrice ?? 0.0
                      : 0.0;
                  debugPrint('Vat $price');
                  final double totalPrice = vat + price;
                  debugPrint('Vat $totalPrice');
                  return Text(
                    '${totalPrice.toStringAsFixed(2)}\$',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w900,
                    ),
                  );
                },
              ),
            ),
            FullWidthButton(
              onTap: () {},
              title: "Add to Cart",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImageGallery(
      double height, List<ImageGallery>? imageGallery) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: imageGallery?.length ?? 0 + 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const Gap(10);
          }
          return AspectRatio(
            aspectRatio: 3 / 3,
            child: CachedNetworkImage(
              imageUrl:
                  imageGallery?[index].url ?? AssetsManager.IMAGE_PLACE_HOLDER,
              fit: BoxFit.cover,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Gap(10);
        },
      ),
    );
  }

  Widget _buildProductVariantGalley(List<Varient>? varient) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        varient?.length ?? 0,
        (index) => ProductVariantCategoryItem(
          title: varient?[index].category ?? '',
          items: varient?[index].items ?? [],
        ),
      ),
    );
  }
  // Widget _buildReview(List<ReviewModel>? reviews) {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: List.generate(
  //       reviews?.length ?? 0,
  //       (index) => ProductReviewCard(
  //         name: reviews?[index].userId ?? '',
  //         review: reviews?[index].review ?? '',
  //       ),
  //     ),
  //   );
  // }
}

// void _androidBackButton(BuildContext context) {
 
// }
   
