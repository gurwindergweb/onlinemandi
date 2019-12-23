import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlinemandi/providers/weights.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_screen.dart';
import '../providers/products.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  var product_type;
  ProductsOverviewScreen({product_type}){

  }
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  var product_type;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final weightModel = Provider.of<Weights>(context);
      product_type == 1 ?
      Provider.of<Products>(context).fetchAndSetProducts(1, weightModel).then((_) {
        setState(() {
          _isLoading = false;
        });
      })
      :
      Provider.of<Products>(context).fetchAndSetVegetables(1, weightModel).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return Scaffold(
      backgroundColor: Color(0xFFe8e3da),
    appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Fruits',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(60))),
        backgroundColor:Color(0xFF609f38),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,color: Colors.white,
            ),
            itemBuilder: (_) => [
                  PopupMenuItem(
                    child: Text('Only Favorites',style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(45))),
                    value: FilterOptions.Favorites,
                  ),
                  PopupMenuItem(
                    child: Text('Show All',style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(45))),
                    value: FilterOptions.All,
                  ),
                ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
                  child: ch,
                  value: cart.itemCount.toString(),
                ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,color: Colors.white,
              ),
              onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
