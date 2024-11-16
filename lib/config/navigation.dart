import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/models/order_model.dart';
import 'package:saree/models/store_type_model.dart';
import 'package:saree/providers/market_provider.dart';
import 'package:saree/providers/order_details_provider.dart';
import 'package:saree/providers/stores_by_category_provider.dart';
import 'package:saree/screens/select_location_from_map_screen.dart';
import 'package:saree/screens/stores_by_category_screen.dart';

import '../models/product_model.dart';
import '../models/store_model.dart';
import '../providers/banners_provider.dart';
import '../providers/order_provider.dart';
import '../providers/product_provider.dart';
import '../providers/search_store_provider.dart';
import '../providers/store_provider.dart';
import '../providers/store_type_provider.dart';
import '../providers/stores_provider.dart';
import '../screens/chose_service_screen.dart';
import '../screens/internal_shipping_screen.dart';
import '../screens/invoice_screen.dart';
import '../screens/loading_screen.dart';
import '../screens/login_screen.dart';
import '../screens/main_screen/main_screen.dart';
import '../screens/order_details_screen.dart';
import '../screens/product_details_screen.dart';
import '../screens/search_stores_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/store_details_screen.dart';
import '../screens/update_password_screen.dart';
import '../screens/update_user_info_screen.dart';
import '../screens/user_info_screen.dart';

class Navigation {
  static String initialRoute = LoginScreen.routeName;

  static final Map<String, Widget Function(BuildContext)> routes = {
    LoginScreen.routeName: (_) => const LoginScreen(),
    SignUpScreen.routeName: (_) => const SignUpScreen(),
    SelectLocationFromMapScreen.routeName: (_) =>
        const SelectLocationFromMapScreen(),
    StoresByCategoryScreen.routeName: (ctx) => ChangeNotifierProvider(
          create: (_) => StoresByCategoryProvider(
              ModalRoute.of(ctx)?.settings.arguments as StoreTypeModel),
          child: const StoresByCategoryScreen(),
        ),
    MainScreen.routeName: (ctx) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => OrdersProvider()),
            ChangeNotifierProvider(create: (_) => BannersProvider()),
            ChangeNotifierProvider(create: (_) => StoreTypeProvider()),
            ChangeNotifierProvider(create: (_) => StoresProvider()),
            ChangeNotifierProvider(create: (_) => MarketProvider()),
          ],
          child: MainScreen(
            arguments:
                ModalRoute.of(ctx)?.settings.arguments as MainScreenArguments?,
          ),
        ),
    SearchStoresScreen.routeName: (ctx) => ChangeNotifierProvider(
          create: (_) => SearchStoreProvider(),
          child: const SearchStoresScreen(),
        ),
    UserInfoScreen.routeName: (_) => const UserInfoScreen(),
    UpdateUserInfoScreen.routeName: (_) => const UpdateUserInfoScreen(),
    UpdateUserPasswordScreen.routeName: (_) => const UpdateUserPasswordScreen(),
    ChoseServiceScreen.routeName: (_) => const ChoseServiceScreen(),
    LoadingScreen.routeName: (ctx) => LoadingScreen(
        ModalRoute.of(ctx)?.settings.arguments as LoadingScreenArguments?),
    StoreDetailsScreen.routeName: (ctx) => ChangeNotifierProvider(
          create: (_) => StoreProvider(
              ModalRoute.of(ctx)?.settings.arguments as StoreModel),
          child: const StoreDetailsScreen(),
        ),
    ProductDetailsScreen.routeName: (ctx) => ChangeNotifierProvider(
          create: (_) => ProductProvider(
              ModalRoute.of(ctx)?.settings.arguments as ProductModel),
          child: const ProductDetailsScreen(),
        ),
    InvoiceScreen.routeName: (_) => const InvoiceScreen(),
    InternalShippingScreen.routeName: (_) => const InternalShippingScreen(),
    OrderDetailsScreen.routeName: (ctx) => ChangeNotifierProvider(
          create: (_) => OrderDetailsProvider(
              ModalRoute.of(ctx)?.settings.arguments as OrderModel),
          child: const OrderDetailsScreen(),
        ),
  };
}
