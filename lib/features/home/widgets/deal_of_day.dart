import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../product_details/screens/product_details_screen.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  final HomeServices homeService = HomeServices();
  Product? product;

  void getDealOfDay() async {
    product = await homeService.fetchDealOfDay(context: context);
    print(product!.name);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    product = null;
  }

  @override
  void initState() {
    super.initState();
    getDealOfDay();
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                      arguments: product);
                },
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text(
                        "Deal of the day",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.network(
                      product!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "\$${product!.price}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      alignment: Alignment.topLeft,
                      child: Text(
                        product!.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: product!.images
                            .map((e) => Image.network(
                                  e,
                                  fit: BoxFit.fitWidth,
                                  width: 100,
                                  height: 100,
                                ))
                            .toList(),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 5),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "See all deals",
                          style: TextStyle(color: Colors.cyan.shade800),
                        ))
                  ],
                ),
              );
  }
}
