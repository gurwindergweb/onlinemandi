import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinemandi/providers/orderitem.dart';
import 'package:onlinemandi/providers/weights.dart';
import 'package:onlinemandi/screens/Term_conditions.dart';
import 'package:onlinemandi/screens/about_us.dart';
import 'package:onlinemandi/screens/care_center.dart';
import 'package:onlinemandi/screens/home_page.dart';
import 'package:onlinemandi/screens/mantines_mode.dart';
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
import 'screens/edit_orders.dart';
import 'screens/forgot_password.dart';
import 'screens/mantainance_mode.dart';
import 'screens/my_wallet.dart';
import 'screens/vegetable_overview_screen.dart';

void main(){
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
    GlobalConfiguration().loadFromMap(appSettings);
    //SystemChrome.setEnabledSystemUIOverlays([]);
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Weights>(
          builder: (ctx, auth, previousProducts) => Weights(
            auth.token,
            auth.userId
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          builder: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Weights>(
          builder: (ctx, auth, previousProducts) => Weights(
            auth.token,
            auth.userId,
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: OrderItem(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          builder: (ctx, auth, previousOrders) => Orders(
            authToken: auth.token,
            userId: auth.userId,
            orderslist: previousOrders == null ? [] : previousOrders.orders,

          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MyShop',
            theme: ThemeData(
              primarySwatch: Colors.lightGreen,
              accentColor: Colors.lightGreen,
              backgroundColor: Colors.white,
              canvasColor: Colors.white,
              fontFamily: 'Lato',
            ),
            home: auth.isAuth && auth.checkMantainance() == false
                ? HomePage()
                : auth.checkMantainance() == true ? FutureBuilder(
              future: auth.tryAutoLogin(),
              builder: (ctx, authResultSnapshot) =>
              authResultSnapshot.connectionState ==
                  ConnectionState.waiting
                  ? SplashScreen()
                  : AuthScreen(),
            ) : MantainanceMode(),
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
              EditOrder.routeName: (ctx) => EditOrder(),
              ForgotPassword.routeName: (ctx) => ForgotPassword(),
              MantainanceMode.routeName: (ctx) => MantainanceMode(),
              HomePage.routeName: (ctx) => HomePage(),
            },
          );
        }
      ),
    );
  }
}
