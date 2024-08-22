// ignore_for_file: deprecated_member_use

import 'package:bd_shop/src/data/prefrence/local_pref.dart';
import 'package:bd_shop/src/data/utils/values.dart';
import 'package:bd_shop/src/presentation/widgets/brand_card.dart';
import 'package:bd_shop/src/presentation/widgets/product_card.dart';
import 'package:bd_shop/src/presentation/widgets/shimmer_effect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../blocs/blocs.dart';
import '../../../routes/routes.dart';
import '../../../utils/assets_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final theme = Theme.of(context);
    final layout = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DrawerHeader(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  child: IconButton(
                      onPressed: () => context.pop(),
                      icon: SvgPicture.asset(
                        AssetsManager.MENU_CLOSE_ICON,
                      )),
                ),
                const Gap(20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(50)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              currentUser!.photoURL.toString(),
                              height: 40.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(currentUser.displayName.toString(),
                                style: theme.textTheme.titleMedium?.copyWith(
                                    color: theme.colorScheme.onBackground,
                                    fontWeight: FontWeight.w600)),
                            Row(
                              children: [
                                Text("Verified Profile",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                            color: theme.colorScheme.outline)),
                                const Gap(5),
                                const Icon(
                                  Icons.verified,
                                  color: Colors.blue,
                                  size: 18,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: 66,
                      height: 32,
                      decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          "3 Order",
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )),
            ListTile(
              title: const Text("Dark Mode"),
              leading: SvgPicture.asset(
                AssetsManager.SUN_ICON,
                // ignore: duplicate_ignore
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
              trailing: Switch(
                  activeColor: Colors.white,
                  activeTrackColor: Colors.green,
                  inactiveTrackColor: Colors.white,
                  value: true,
                  onChanged: (value) {}),
            ),
            InkWell(
              onTap: () => context.pushNamed(Routes.PROFILE_ROUTE),
              child: ListTile(
                title: Text(
                  "Account Information",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                leading: SvgPicture.asset(
                  AssetsManager.INFO_CIRCLE,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Password",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              leading: SvgPicture.asset(
                AssetsManager.LOCK_ICON,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
            ListTile(
              title: Text(
                "Order",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              leading: SvgPicture.asset(
                AssetsManager.CART_BAG,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
            ListTile(
              title: Text(
                "My Cards",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              leading: SvgPicture.asset(
                AssetsManager.WALLET_ICON,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
            ListTile(
              title: Text(
                "Wishlist",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              leading: SvgPicture.asset(
                AssetsManager.HEART_ICON,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
            ListTile(
              title: Text(
                "Settings",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              leading: SvgPicture.asset(
                AssetsManager.SETTINGS_ICON,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
            const Spacer(),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LogOutSuccess) {
                  context.goNamed(Routes.WELCOME_ROUTE);
                }
              },
              child: InkWell(
                onTap: () => context.read<LoginBloc>().add(RequestLogOut()),
                child: ListTile(
                  title: Text(
                    "Logout",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Theme.of(context).colorScheme.error),
                  ),
                  leading: SvgPicture.asset(
                    AssetsManager.LOGOUT_ICON,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            ),
            const Gap(100)
          ],
        ),
      ),
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, isScrollable) => [
            SliverAppBar(
              surfaceTintColor: theme.colorScheme.background,
              foregroundColor: theme.colorScheme.background,
              backgroundColor: theme.colorScheme.background,
              floating: true,
              leading: IconButton.filled(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        theme.colorScheme.surfaceVariant)),
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: SvgPicture.asset(
                  AssetsManager.MENU_ICON,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              actions: [
                IconButton.filled(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            theme.colorScheme.surfaceVariant)),
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      AssetsManager.CART_BAG,
                      color: theme.colorScheme.onSurface,
                    )),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "${Values.GREETINGS} ${LocalPreferences.getString('username')}",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Welcome to Laza",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.outlineVariant),
                    ),
                  ),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 85,
                            child: SizedBox(
                              child: TextFormField(
                                cursorColor: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                                decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: SvgPicture.asset(
                                        AssetsManager.SEARCH_ICON,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Theme.of(context)
                                        .colorScheme
                                        .surfaceVariant,
                                    hintText: 'Search...',
                                    hintStyle: theme.textTheme.titleMedium
                                        ?.copyWith(
                                            color: theme.colorScheme.outline),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 15,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: theme.colorScheme.onPrimaryContainer,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: SvgPicture.asset(
                                  AssetsManager.VOICE_ICON,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  const Gap(20),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.13,
                    child: BlocBuilder<BrandBloc, BrandState>(
                      builder: (context, state) {
                        if (state is BrandSuccess) {
                          return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.brands.length + 1,
                              separatorBuilder: (context, index) =>
                                  const Gap(8.0),
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return const Gap(10);
                                }
                                return BrandCard(
                                    brandTitle:
                                        state.brands[index - 1].brandTitle,
                                    brandLogo:
                                        state.brands[index - 1].brandLogo);
                              });
                        } else {
                          return ListView.separated(
                              itemBuilder: (context, index) =>
                                  ShimmerEffect.rectangular(
                                    width: 100,
                                    height: MediaQuery.of(context).size.width *
                                        0.13,
                                  ),
                              separatorBuilder: (context, index) =>
                                  const Gap(8.0),
                              itemCount: 10);
                        }
                      },
                    ),
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ],
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(
                child: Gap(20),
              ),
              SliverToBoxAdapter(
                child: ListTile(
                  title: const Text('New Arraival'),
                  titleTextStyle: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                  trailing: Text(
                    "View All",
                    style: theme.textTheme.labelSmall,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                  if (state is ProductSuccess) {
                    return SliverGrid.builder(
                        itemCount: state.product.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            mainAxisExtent: layout.width * 0.7),
                        itemBuilder: (context, index) {
                          return ProductCard(
                            onItemTap: () {
                              context.read<ProductBloc>().add(
                                  FetchSingleProduct(
                                      state.product[index].productId));
                              context.read<RatingBloc>().add(FetchProductReview(
                                  state.product[index].productId));
                              context.read<CategoryBloc>().add(
                                  FetchSingleCategory(
                                      state.product[index].categoryId ?? ''));
                              context.pushNamed(Routes.PRODUCT_DETAILS_ROUTE);
                            },
                            productTitle:
                                state.product[index].productTitle ?? 'Unknown',
                            productPrice: state.product[index].productPrice,
                            productThumbnail:
                                state.product[index].imageGallery?.first.url,
                          );
                        });
                  } else {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



















// CustomScrollView(
//             physics: const BouncingScrollPhysics(),
//             slivers: [
//               const SliverToBoxAdapter(
//                 child: Gap(20),
//               ),
//               SliverToBoxAdapter(
//                 child: ListTile(
//                   title: const Text('New Arraival'),
//                   titleTextStyle: theme.textTheme.titleMedium
//                       ?.copyWith(fontWeight: FontWeight.w600),
//                   trailing: Text(
//                     "View All",
//                     style: theme.textTheme.labelSmall,
//                   ),
//                 ),
//               ),
//               SliverPadding(
//                   padding: const EdgeInsets.all(8.0),
//                   sliver: BlocBuilder<ProductBloc, ProductState>(
//                     builder: (context, state) {
//                       if (state is ProductSuccess) {
//                         return SliverGrid.builder(
//                           itemCount: state.product.length,
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 2,
//                                   mainAxisSpacing: 8,
//                                   crossAxisSpacing: 8,
//                                   mainAxisExtent: layout.width * 0.7),
//                           itemBuilder: (context, index) => 
                          
//                         );
//                       } else {
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//                     },
//                   ))
//             ],
//           ),