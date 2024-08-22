import 'package:bd_shop/application/bd_shop.dart';
import 'package:bd_shop/firebase_options.dart';
import 'package:bd_shop/src/blocs/shopbd_observer.dart';
import 'package:bd_shop/src/data/prefrence/local_pref.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
    );
    Bloc.observer = ShopBdBlocObserver();
    await LocalPreferences().init();
  runApp(const BdShop());
}