// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/product_details/services/product_services.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone/models/product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';
import '../../search/screen/search_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailServices productDetailServices = ProductDetailServices();
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).user.id;
    final initialRating = getRatingByUser(widget.product, userId);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: GlobalVariables.appBarGradient)),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    elevation: 1.0,
                    borderRadius: BorderRadius.circular(7),
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1),
                        ),
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                          color: Colors.black38,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.only(top: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25)),
          ]),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.product.id!),
                    Stars(rating: calculateRating(widget.product))
                  ],
                )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            CarouselSlider(
              items: widget.product.images.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.network(
                      i,
                      fit: BoxFit.contain,
                      height: 200,
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(viewportFraction: 1, height: 250),
            ),
            const Divider(
              thickness: 5,
              height: 5,
              color: Colors.black12,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                  text: 'Deal Price ',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: '\$${widget.product.price}',
                        style: const TextStyle(
                            fontSize: 22,
                            color: Colors.red,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.description),
            ),
            const Divider(
              thickness: 5,
              height: 5,
              color: Colors.black12,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(text: 'Buy Now', onTap: () {}),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                text: 'Add to cart',
                onTap: () {},
                color: const Color.fromRGBO(254, 216, 19, 1),
                textColor: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 5,
              height: 5,
              color: Colors.black12,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                'Rate The Product',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            RatingBar.builder(
                initialRating: initialRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(Icons.star,
                    color: GlobalVariables.secondaryColor),
                onRatingUpdate: (rating) {
                  productDetailServices.rateProduct(
                      context: context,
                      product: widget.product,
                      rating: rating);
                  setState(() {});
                })
          ],
        ),
      ),
    );
  }
}
