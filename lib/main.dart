import 'package:flutter/material.dart';
import 'package:onlinemandi/screens/Term_conditions.dart';
import 'package:onlinemandi/screens/about_us.dart';
import 'package:onlinemandi/screens/care_center.dart';
import 'package:onlinemandi/screens/my_account.dart';
import 'package:onlinemandi/screens/my_order.dart';
import 'package:onlinemandi/screens/user_detail.dart';
import 'package:provider/provider.dart';
import 'package:global_configuration/global_configuration.dart';
import 'config/config.dart';
import './screens/splash_screen.dart';
import './screens/cart_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './screens/change_password.dart';
import 'screens/checkout.dart';
import 'screens/my_wallet.dart';

void main(){
  GlobalConfiguration().loadFromMap(appSettings);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          builder: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          builder: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.lightGreen,
            accentColor: Colors.deepOrange,
            backgroundColor: Colors.white,
            canvasColor: Colors.white,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (ctx, authResultSnapshot) =>
            authResultSnapshot.connectionState ==
                ConnectionState.waiting
                ? SplashScreen()
                : AuthScreen(),
          ),
          routes: {
            //ProductDetailScreen.routeName: (ctx) => AuthScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
            About.routeName: (ctx) => About(),
            MyAccount.routeName: (ctx) => MyAccount(),
            UserDetail.routeName: (ctx) => UserDetail(),
            CareCenter.routeName: (ctx) => CareCenter(),
            MyOrder.routeName: (ctx) => MyOrder(),
            ChangePassword.routeName: (ctx) => ChangePassword(),
            MyWallet.routeName: (ctx) => MyWallet(),
            Checkout.routeName: (ctx) => Checkout(),
          },
        ),
      ),
    );
  }
}
