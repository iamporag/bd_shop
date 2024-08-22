
import 'package:bd_shop/src/blocs/nav/nav_bloc.dart';
import 'package:bd_shop/src/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/nav_widgets.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBloc,NavState>(
      builder: (context,state){
       return Scaffold(
        // appBar: AppBar(
        // ),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.onSecondaryFixed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 0.0),
          child: NavigationBar(
            onDestinationSelected: (int index) {
              context.read<NavBloc>().add(TriggerNavEvent(index: index));
            },
            indicatorColor: Colors.transparent,
            selectedIndex: state is NavInitial ? state.index : 0,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            destinations: [
             NavigationDestination(
              icon: SvgPicture.asset(AssetsManager.HOME_ICON,color: Theme.of(context).colorScheme.inverseSurface,), 
              label: "Home"
              ),
             NavigationDestination(
              icon: SvgPicture.asset(AssetsManager.HEART_ICON,color: Theme.of(context).colorScheme.inverseSurface,), 
              label: "Wishlist"
              ),
             NavigationDestination(
              icon: SvgPicture.asset(AssetsManager.CART_BAG,color: Theme.of(context).colorScheme.inverseSurface,), 
              label: "Cart"
              ),
             NavigationDestination(
              icon: SvgPicture.asset(AssetsManager.WALLET_ICON,color: Theme.of(context).colorScheme.inverseSurface,),
              
              label: "Wallet"
              ),
            ],

            )
          
          // GNav(
          //   gap: 5,
          //   backgroundColor: Theme.of(context).colorScheme.onSecondaryFixed,
          //   activeColor: Theme.of(context).colorScheme.onSurface,
          //   tabBackgroundColor: Colors.grey,
          //   padding: const EdgeInsets.all(15),
          //   onTabChange: (value) {
          //     context.read<NavBloc>().add(TriggerNavEvent(index: value));
          //   },
          //   tabs: [
          //       GButton(
          //           icon: Icons.home,
          //           iconColor: Theme.of(context).colorScheme.outlineVariant,
          //           text: "Home",
          //           textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onSecondaryFixed)
          //        ),
          //         GButton(
          //           icon: Icons.explore,
          //           iconColor: Theme.of(context).colorScheme.outlineVariant,
          //           text: "Explore",
          //           textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onSecondaryFixed)
          //         ),
          //         GButton(
          //           icon: Icons.bookmark,
          //           iconColor: Theme.of(context).colorScheme.outlineVariant,
          //           text: "Bookmark",
          //           textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onSecondaryFixed)
          //         ),
          //         GButton(
          //           icon: Icons.account_circle,
          //           iconColor: Theme.of(context).colorScheme.outlineVariant,
          //           text: "Profile",
          //           textStyle:Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onSecondaryFixed)
          //         ),
          //   ]
          //   ),
          ),
          
      ),
      body: buildPage(state is NavInitial ? state.index : 0),
    );
      }
      );
  }
}