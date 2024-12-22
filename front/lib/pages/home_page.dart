import 'package:flutter/material.dart';
import 'package:front/models/cart_model.dart';
import 'package:front/pages/add_item_page.dart';
import 'package:front/pages/itam_page.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/product_model.dart';
import 'package:front/models/favourites_model.dart';
import 'package:front/styles/home_styles.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Product>> _products;
  late List<Product> _productsUpd;
  late List<Cart> cartItems = [];
  late List<Favourites> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _products = ApiService().getProducts();
    _fetchFavorites();
    _fetchCart();
    ApiService().getProducts().then(
          (el) => {_productsUpd = el},
    );
  }

  void _fetchFavorites() async {
    try {
      favoriteItems = await ApiService().getFavorites(1);
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

  void _setUpd() {
    setState(() {
      _products = ApiService().getProducts();
      _fetchFavorites();
      _fetchCart();
      ApiService().getProducts().then(
            (el) => {_productsUpd = el},
      );
    });
  }

  void _navigateToAddFlavorScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddFlavorScreen()),
    );
    _setUpd();
  }

  void _addToFavorites(Product i) async {
    await ApiService().addToFavorites(1, i.id);
    _fetchFavorites();
    _setUpd();
  }

  void _deleteFromFavourites(Product i) async {
    await ApiService().removeFromFavorites(1, i.id);
    _fetchFavorites();
    _setUpd();
  }

  void _deleteFromCart(Product i) async {
    await ApiService().removeFromCart(1, i.id);
    _fetchCart();
    _setUpd();
  }

  void addTOCart(Product i) async {
    int quantity = 1;
    await ApiService().addToCart(1, i.id, quantity);
    _fetchCart();
    _setUpd();
  }

  void _openItem(int id) async {
    final product = await ApiService().getProductById(id);
    int? answer = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItamPage(
          flavor: product,
        ),
      ),
    );
    _setUpd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Модели автомобилей",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppTheme.appBarColor,
      ),
      body: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Модели не добавлены'));
          }

          final items = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.61,
            ),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final flavor = items[index];
              bool isFavorite =
              favoriteItems.any((product) => product.id == flavor.id);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => {_openItem(flavor.id)},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppTheme.cardColor,
                        borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    child: Column(
                      children: [
                        Image.network(
                          flavor.imageUrl,
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 20.0),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                flavor.name,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 3.0),
                              Text(
                                flavor.description,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.subtitleColor),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                "Цена: ${flavor.price.toString()}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.priceColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 3.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (favoriteItems.any((product) =>
                                product.productid == flavor.id)) {
                                  _deleteFromFavourites(flavor);
                                } else {
                                  _addToFavorites(flavor);
                                }
                              },
                              icon: favoriteItems.any((product) =>
                              product.productid == flavor.id)
                                  ? const Icon(Icons.favorite,
                                  color: AppTheme.buttonColor)
                                  : const Icon(Icons.favorite_border,
                                  color: AppTheme.buttonColor),
                            ),
                            const SizedBox(width: 20.0),
                            IconButton(
                              onPressed: () {
                                if (cartItems.any((product) =>
                                product.productid == flavor.id)) {
                                  _deleteFromCart(flavor);
                                } else {
                                  addTOCart(flavor);
                                }
                              },
                              icon: cartItems.any((product) =>
                              product.productid == flavor.id)
                                  ? const Icon(Icons.shopping_cart,
                                  color: AppTheme.buttonColor)
                                  : const Icon(Icons.add_shopping_cart,
                                  color: AppTheme.buttonColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3.0),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddFlavorScreen(context),
        tooltip: 'Добавить модель',
        child: const Icon(Icons.add),
      ),
    );
  }
}
