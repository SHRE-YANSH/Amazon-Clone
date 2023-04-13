import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/home/screen/category_deals_screen.dart';
import 'package:amazon_clone/features/home/screen/home_screen.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/features/search/screen/search_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'features/auth/screens/auth_screen.dart';

Route<dynamic> generateRoute(RouteSettings routerSettings) {
  switch (routerSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routerSettings,
          builder: (_) {
            return const AuthScreen();
          });
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routerSettings,
          builder: (_) {
            return const HomeScreen();
          });
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routerSettings,
          builder: (_) {
            return const AddProductScreen();
          });
    case SearchScreen.routeName:
      var searchQuery = routerSettings.arguments as String;
      return MaterialPageRoute(
          settings: routerSettings,
          builder: (_) {
            return SearchScreen(
              searchQuery: searchQuery,
            );
          });
    case CategoryDealsScreen.routeName:
      var category = routerSettings.arguments as String;
      return MaterialPageRoute(
          settings: routerSettings,
          builder: (_) {
            return CategoryDealsScreen(category: category);
          });
    case ProductDetailsScreen.routeName:
      var product = routerSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routerSettings,
          builder: (_) {
            return ProductDetailsScreen(product: product);
          });
    default:
      return MaterialPageRoute(
          settings: routerSettings,
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text("404"),
              ),
            );
          });
  }
}
