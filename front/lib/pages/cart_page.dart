import 'package:flutter/material.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/product_model.dart';
import 'package:front/pages/itam_page.dart';
import 'package:front/models/cart_model.dart';
import 'package:front/models/favourites_model.dart';
import 'package:front/styles/cart_styles.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({
    super.key,
  });

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  late Future<List<Cart>> _cartProducts;
  late List<Cart> _cartProductsUpd;
  late List<Favourites> _favProducts;

  @override
  void initState() {
    super.initState();
    _cartProducts = ApiService().getCart(1);
    ApiService().getCart(1).then(
          (i) => {_cartProductsUpd = i},
    );
  }

  void _setUpd() {
    setState(() {
      _cartProducts = ApiService().getCart(1);
      ApiService().getCart(1).then(
            (value) => {_cartProductsUpd = value},
      );
    });
  }

  void _fetchFavourites() async {
    try {
      _favProducts = await ApiService().getFavorites(1);
      setState(() {});
    } catch (e) {
      print('Error fetching cart: $e');
    }
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
  }

  void _deleteFromCart(int i) async {
    await ApiService().removeFromCart(1, i);
    setState(() {});
    _setUpd();
  }

  void _addToFavorites(int i) async {
    await ApiService().addToFavorites(1, i);
    _setUpd();
  }

  void _deleteFromFavourites(int i) async {
    await ApiService().removeFromFavorites(1, i);
    _setUpd();
  }

  void plus(Cart item) async {
    int newQuantity = item.quantity + 1;
    if (newQuantity <= item.stock) {
      await ApiService().removeFromCart(1, item.productid);
      await ApiService().addToCart(1, item.productid, newQuantity);
    }
    _setUpd();
  }

  void minus(Cart item) async {
    final count = item.quantity;

    if (count > 1) {
      int newQuantity = count - 1;
      await ApiService().removeFromCart(1, item.productid);
      await ApiService().addToCart(1, item.productid, newQuantity);
    }

    _setUpd();
  }

  Future<bool?> _showConfirmedDialog(BuildContext context, Cart flavor) {
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text(
                'Удалить из корзины?',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.network(
                  'flavor.imageUrl',
                  width: 150,
                  height: 150,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Ошибка загрузки изображения');
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  "Отмена",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color.fromRGBO(160, 149, 108, 1),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  "Удалить",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color.fromRGBO(118, 103, 49, 1),
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Корзина",
            style: CartPageTheme.appBarTextStyle,
          ),
          backgroundColor: CartPageTheme.appBarColor,
        ),
        backgroundColor: CartPageTheme.backgroundColor,
        body: FutureBuilder<List<Cart>>(
            future: _cartProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Ошибка: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('В корзине ничего нет'));
              }

              final cartItems = snapshot.data!;

              return Stack(
                children: [
                  ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 6,
                      ),
                      itemCount: cartItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        final flavor =
                        cartItems[index]; //каждый id из списка cart
                        return Dismissible(
                            key: Key(flavor.id.toString()),
                            background: Container(
                              color: const Color.fromRGBO(247, 163, 114, 1),
                              alignment: Alignment.centerRight,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              child: const Icon(Icons.delete),
                            ),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) async {
                              final confirmed =
                              await _showConfirmedDialog(context, flavor);

                              return confirmed ?? false;
                            },
                            onDismissed: (direction) {
                              _setUpd();
                              _deleteFromCart(flavor.productid);
                              _setUpd();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        '${flavor.name} удален из корзины')),
                              );
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                    onTap: () => {_openItem(flavor.productid)},
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(20.0)),
                                      padding: const EdgeInsets.all(10),
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Image.network(
                                                flavor.imageUrl,
                                                width: 120,
                                                height: 120,
                                                fit: BoxFit.cover,
                                              ),
                                              const SizedBox(
                                                width: 20.0,
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        flavor.name,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        flavor.description,
                                                        maxLines: 2,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                            Color.fromARGB(
                                                                255,
                                                                65,
                                                                65,
                                                                65)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Цена: ${(flavor.price * flavor.quantity).toString()} ₽",
                                                style: CartPageTheme.priceTextStyle,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              IconButton(
                                                  onPressed: () => {
                                                    minus(_cartProductsUpd
                                                        .elementAt(index))
                                                  },
                                                  icon:
                                                  const Icon(Icons.remove)),
                                              Text(_cartProductsUpd
                                                  .elementAt(index)
                                                  .quantity
                                                  .toString()),
                                              IconButton(
                                                  onPressed: () => {
                                                    plus(_cartProductsUpd
                                                        .elementAt(index))
                                                  },
                                                  icon: const Icon(Icons.add)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))));
                      }),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {},
                              style: CartPageTheme.buttonStyle,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${cartItems.fold(0.0, (sum, item) => sum + item.quantity * item.price)} ₽',
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 80.0,
                                  ),
                                  const Text(
                                    'оплатить',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              );
            }));
  }
}
