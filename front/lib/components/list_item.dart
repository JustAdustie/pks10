import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front/models/cart_model.dart';
import 'package:front/models/product_model.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/favourites_model.dart';

class ListItem extends StatefulWidget {
  const ListItem(
      {super.key,
      required this.flavor,
      required this.onAddToFavourites,
      required this.onAddToCart,
      required this.onDeleteFromFavourites,
      required this.onDeleteFromCart,
      required this.NavToItemPage});
  final Favourites flavor;
  final Function(int i) onAddToFavourites;
  final Function(int i) onAddToCart;
  final Function(int i) onDeleteFromFavourites;
  final Function(int i) onDeleteFromCart;
  final Function(int i) NavToItemPage;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late Future<Product> _product;
  late List<Cart> cartItems = [];
  late List<Favourites> favouriteItems = [];
  @override
  void initState() {
    super.initState();
    _product = ApiService().getProductById(widget.flavor.productid);
    _fetchFavorites();
    _fetchCart();
  }

  void _fetchFavorites() async {
    try {
      favouriteItems = await ApiService().getFavorites(1);
      setState(() {});
    } catch (e) {
      print('Error fetching favorites: $e');
    }
  }

  void _fetchCart() async {
    try {
      cartItems = await ApiService().getCart(1);
      setState(() {});
    } catch (e) {
      print('Error fetching cart: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {widget.NavToItemPage(widget.flavor.productid)},
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Column(
          children: [
            Image.network(
              widget.flavor.imageUrl,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.flavor.name,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    widget.flavor.description,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 65, 65, 65)),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Цена: ${widget.flavor.price.toString()}",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 65, 65, 65),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 3.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      widget.onDeleteFromFavourites(widget.flavor.productid);
                    },
                    icon: const Icon(Icons.favorite,
                        color: Color.fromRGBO(160, 149, 108, 1))),
                const SizedBox(width: 20.0),
                IconButton(
                  onPressed: () {
                    if (cartItems.any((product) =>
                        product.productid == widget.flavor.productid)) {
                      widget.onDeleteFromCart(widget.flavor.productid);
                    } else {
                      widget.onAddToCart(widget.flavor.productid);
                    }
                  },
                  icon: cartItems.any((product) =>
                          product.productid == widget.flavor.productid)
                      ? const Icon(Icons.shopping_cart,
                          color: Color.fromRGBO(160, 149, 108, 1))
                      : const Icon(Icons.add_shopping_cart,
                          color: Color.fromRGBO(160, 149, 108, 1)),
                ),
              ],
            ),
            const SizedBox(
              height: 3.0,
            ),
          ],
        ),
      ),
    );
  }
}
