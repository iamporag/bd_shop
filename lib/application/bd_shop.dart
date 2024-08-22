
import 'package:bd_shop/src/blocs/store/rating_point/rating_point_cubit.dart';
import 'package:bd_shop/src/blocs/store/review_image/review_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../src/blocs/blocs.dart';
import '../src/data/repository/repository.dart';
import '../src/routes/route_pages.dart';
import '../theme/theme.dart';

class BdShop extends StatelessWidget {
  const BdShop({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context)=> AuthRepository()),
        RepositoryProvider(create: (context)=> StoreRepository()),
        RepositoryProvider(create: (context)=> ProductRepository()),
        // RepositoryProvider(create: (context)=> ProfileRepository()),
      ], 
      child: MultiBlocProvider(
        providers: [
            BlocProvider(create: (context) => SplashCubit()..startSplash()),
            BlocProvider(create: (context) => RememberCubit()),
            BlocProvider(create: (context) => SignupBloc(context.read<AuthRepository>())),
            BlocProvider(create: (context) => LoginBloc(context.read<AuthRepository>())),
            BlocProvider(create: (context) => NavBloc()),
            BlocProvider(create: (context) => BrandBloc(context.read<StoreRepository>())..add(FeatchBrand())),
            BlocProvider(create: (context) => ProductBloc(context.read<ProductRepository>())..add(FetchProduct())),
            BlocProvider(create: (context) => CategoryBloc(context.read<StoreRepository>())),
            BlocProvider(create: (context) => RatingBloc(context.read<ProductRepository>())),
            BlocProvider(create: (context) => RatingPointCubit()),
            BlocProvider(create: (context) => ReviewImageCubit()),
            // BlocProvider(create: (context) => ProfileBloc(context.read<ProfileRepository>())),
          ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              theme: MaterialTheme(TextTheme()).light(),
              darkTheme: MaterialTheme(TextTheme()).dark(),
              debugShowCheckedModeBanner: false,
              routerConfig: RoutePages.ROUTER,
            );
          },
        ))
        );
  }
}