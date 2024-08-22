import 'package:bd_shop/src/presentation/screens/add_review.dart';
import 'package:bd_shop/src/presentation/screens/explore_review.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/services/auth_service.dart';
import '../presentation/screens/screen.dart';
import 'routes.dart';

class RoutePages {
  static final authService = AuthService();
  static final ROUTER = GoRouter(
      redirect: (context, state) {
        if (authService.checkLoginState()) {
          if (state.fullPath == Routes.LOGIN_ROUTE ||
              state.fullPath == Routes.REGISTER_ROUTE ||
              state.fullPath == Routes.WELCOME_ROUTE) {
            return Routes.HOME_ROUTE;
          } else {
            return state.fullPath;
          }
        } else {
          if (state.fullPath == Routes.LOGIN_ROUTE ||
              state.fullPath == Routes.REGISTER_ROUTE ||
              state.fullPath == Routes.WELCOME_ROUTE) {
            return state.fullPath;
          }
          return Routes.WELCOME_ROUTE;
        }
      },
      routes: [
        GoRoute(
            path: Routes.SPLASH_ROUTE,
            name: Routes.SPLASH_ROUTE,
            pageBuilder: (context, state) => const MaterialPage(
                  child: SplashScreen(),
                )),
        GoRoute(
            path: Routes.WELCOME_ROUTE,
            name: Routes.WELCOME_ROUTE,
            pageBuilder: (context, state) => const MaterialPage(
                  child: WelcomeScreen(),
                )),
        GoRoute(
            path: Routes.LOGIN_ROUTE,
            name: Routes.LOGIN_ROUTE,
            pageBuilder: (context, state) =>
                const MaterialPage(child: LoginScreen())),
        GoRoute(
          path: Routes.REGISTER_ROUTE,
          name: Routes.REGISTER_ROUTE,
          pageBuilder: (context, state) => const MaterialPage(
            child: SignUpScreen(),
          ),
        ),
        GoRoute(
          path: Routes.FORGET_PASSWORD,
          name: Routes.FORGET_PASSWORD,
          pageBuilder: (context, state) => const MaterialPage(
            child: ForgetPasswordScreen(),
          ),
        ),
        GoRoute(
          path: Routes.NEW_PASSWORD,
          name: Routes.NEW_PASSWORD,
          pageBuilder: (context, state) =>
              const MaterialPage(child: NewPassword()),
        ),
        GoRoute(
          path: Routes.PRODUCT_DETAILS_ROUTE,
          name: Routes.PRODUCT_DETAILS_ROUTE,
          pageBuilder: (context, state) =>
              const MaterialPage(child: ProductDetailsScreen()),
        ),
        GoRoute(
          path: Routes.ADD_REVIEW_ROUTE,
          name: Routes.ADD_REVIEW_ROUTE,
          pageBuilder: (context, state) {
            final obj = state.extra as Map;
            return MaterialPage(
            child: AddReview(
              id: obj['id'],
            ),
          );
          },
        ),
        GoRoute(
          path: Routes.EXPLORE_REVIEW_ROUTE,
          name: Routes.EXPLORE_REVIEW_ROUTE,
          pageBuilder: (context, state) => MaterialPage(
            child: ExploreReview(),
          ),
        ),
        ShellRoute(
            builder: (context, state, child) => Wrapper(child: child),
            routes: [
              GoRoute(
                path: Routes.HOME_ROUTE,
                name: Routes.HOME_ROUTE,
                pageBuilder: (context, state) =>
                    const MaterialPage(child: Navigation()),
              ),
              GoRoute(
                path: Routes.PROFILE_ROUTE,
                name: Routes.PROFILE_ROUTE,
                pageBuilder: (context, state) =>
                    const MaterialPage(child: UserProfileScreen()),
              ),
            ])
      ]);
}
