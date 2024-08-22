// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:bd_shop/src/blocs/blocs.dart';
import 'package:bd_shop/src/blocs/store/rating_point/rating_point_cubit.dart';
import 'package:bd_shop/src/blocs/store/review_image/review_image_cubit.dart';
import 'package:bd_shop/src/presentation/widgets/full_width_button.dart';
import 'package:bd_shop/src/routes/routes.dart';
import 'package:bd_shop/src/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class AddReview extends StatelessWidget {
  const AddReview({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final layout = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        surfaceTintColor: theme.colorScheme.background,
        leading: IconButton.filled(
          style: ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(theme.colorScheme.surfaceVariant),
          ),
          onPressed: () {
            // context.read<ProductBloc>().add(FetchProduct());
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          "Add Review",
          style: theme.textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<RatingBloc, RatingState>(builder: (context, state) {
        if (state is RatingInitial) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "How was your experience ?",
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: theme.colorScheme.onBackground),
                ),
                Gap(10.h),
                TextField(
                  controller: state.ratingReviewController,
                  maxLines: 10,
                  style: theme.textTheme.labelSmall
                      ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  decoration: InputDecoration(
                    hintText: "Describe your Experience?",
                    hintStyle: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.outline),
                    fillColor: theme.colorScheme.surfaceVariant,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                  ),
                ),
                Gap(10.h),
                Text(
                  "Rating",
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: theme.colorScheme.onBackground),
                ),
                Gap(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BlocBuilder<RatingPointCubit, RatingPointState>(
                      builder: (context, state) => RatingBar.builder(
                        initialRating: state is RatingPointChanged
                            ? state.ratingPoint
                            : context.read<RatingPointCubit>().ratingPoint,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) => context
                            .read<RatingPointCubit>()
                            .updateRatingPoint(rating),
                      ),
                    ),
                    BlocBuilder<RatingPointCubit, RatingPointState>(
                      builder: (context, state) => Text(
                        state is RatingPointChanged
                            ? state.ratingPoint.toString()
                            : context
                                .read<RatingPointCubit>()
                                .ratingPoint
                                .toString(),
                        style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontSize: 35),
                      ),
                    ),
                  ],
                ),
                Gap(20.h),
                SizedBox(
                  height: layout.height * 0.14,
                  child: BlocBuilder<ReviewImageCubit, ReviewImageState>(
                    builder: (context, state) => ListView.separated(
                      itemCount: state is ReviewImageAdded
                          ? state.images.length + 1
                          : state is ReviewImageRemoved
                              ? state.images.length + 1
                              : context
                                      .read<ReviewImageCubit>()
                                      .selectedReviewImages
                                      .length +
                                  1,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return AspectRatio(
                            aspectRatio: 3 / 3,
                            child: InkWell(
                              onTap: () =>
                                  context.read<ReviewImageCubit>().picImage(),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: theme.colorScheme.surfaceVariant,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: theme.colorScheme.outline,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return state is ReviewImageAdded ||
                                state is ReviewImageRemoved
                            ? AspectRatio(
                                aspectRatio: 3 / 3,
                                child: Stack(
                                  children: [
                                    state is ReviewImageAdded
                                        ? Image(
                                            image: FileImage(
                                              File(
                                                  state.images[index - 1].path),
                                            ),
                                          )
                                        : state is ReviewImageRemoved
                                            ? Image(
                                                image: FileImage(
                                                  File(state
                                                      .images[index - 1].path),
                                                ),
                                              )
                                            : Container(),
                                    Positioned(
                                        right: 2,
                                        top: 2,
                                        child: InkWell(
                                          onTap: () => context
                                              .read<ReviewImageCubit>()
                                              .removeImage(index - 1),
                                          child: Icon(
                                            Icons.close,
                                            color: theme.colorScheme.onPrimary,
                                          ),
                                        ))
                                  ],
                                ))
                            : null;
                      },
                      separatorBuilder: (context, index) => Gap(20.w),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is RatingLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RatingSubmitSuccess) {
          return AlertDialog(
            backgroundColor: theme.colorScheme.onInverseSurface,
            title: Center(
              child: Text(
                "Review Submitted!",
                style: theme.textTheme.titleLarge
                    ?.copyWith(color: theme.colorScheme.onSurface),
              ),
            ),
            content: LottieBuilder.asset(AssetsManager.SUCCESS_ANIMATION),
          );
        } else {
          return Container(
            child: Text('Sumething Wrong'),
          );
        }
      }, listener: (context, state) {
        if (state is RatingSubmitSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Thanks For Submit Review",
                style: theme.textTheme.labelMedium
                    ?.copyWith(color: theme.colorScheme.onErrorContainer),
              ),
              backgroundColor: Colors.green,
            ),
          );
          Future.delayed(Duration(milliseconds: 200), () {
            context.read<RatingBloc>();
            context.pushReplacement(Routes.EXPLORE_REVIEW_ROUTE);
          });
        }
        if (state is RatingSubmitFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Thanks For Submit Failed",
                style: theme.textTheme.labelMedium
                    ?.copyWith(color: theme.colorScheme.onErrorContainer),
              ),
              backgroundColor: theme.colorScheme.errorContainer,
            ),
          );
        }
      }),
      bottomNavigationBar: BlocBuilder<RatingBloc, RatingState>(
        builder: (context, state) {
          return FullWidthButton(
            onTap: () => state is RatingInitial
                ? context.read<RatingBloc>().add(
                      SubmitRatingReview(
                          state.ratingReviewController.text,
                          id,
                          context.read<RatingPointCubit>().ratingPoint,
                          context
                              .read<ReviewImageCubit>()
                              .selectedReviewImages),
                    )
                : null,
            buttonChild:
                state is RatingLoading ? CircularProgressIndicator() : null,
            title: "Submit Review",
          );
        },
      ),
    );
  }
}
