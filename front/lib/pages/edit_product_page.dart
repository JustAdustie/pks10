import 'package:flutter/material.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/product_model.dart';
import 'package:front/styles/edit_product_styles.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key, required this.flavor});
  final Product flavor;

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late Future<Product> item;
  final TextEditingController _nameFlavorController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _dopController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void initState() {
    super.initState();
    ApiService().getProductById(widget.flavor.id).then((i) => {
      _nameFlavorController.text = i.name,
      _imageController.text = i.imageUrl,
      _descController.text = i.description,
      _dopController.text = i.feature,
      _priceController.text = i.price.toString(),
    });
  }

  void dispose() {
    _nameFlavorController.dispose();
    _imageController.dispose();
    _descController.dispose();
    _dopController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Изменение данных автомобиля",
          style: TextStyle(
            color: Colors.black,
            fontSize: 21.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 0, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Название модели',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.labelColor),
                ),
              ),
              TextField(
                controller: _nameFlavorController,
                decoration: AppTheme.inputDecoration('Имя модели'),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Фото автомобиля',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.labelColor),
                ),
              ),
              TextField(
                controller: _imageController,
                decoration: AppTheme.inputDecoration('Ссылка на фото'),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Комплектация',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.labelColor),
                ),
              ),
              TextField(
                controller: _descController,
                decoration: AppTheme.inputDecoration('Комплектация'),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Характеристики',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.labelColor),
                ),
              ),
              TextField(
                controller: _dopController,
                decoration: AppTheme.inputDecoration('Характеристики'),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Цена',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.labelColor),
                ),
              ),
              TextField(
                controller: _priceController,
                decoration: AppTheme.inputDecoration('Цена'),
              ),
              const SizedBox(height: 60),
              Center(
                child: ElevatedButton(
                  style: AppTheme.elevatedButtonStyle,
                  onPressed: () async {
                    double price = double.parse(_priceController.text);
                    if (_nameFlavorController.text.isNotEmpty &&
                        _imageController.text.isNotEmpty &&
                        _descController.text.isNotEmpty &&
                        _dopController.text.isNotEmpty &&
                        _priceController.text.isNotEmpty) {
                      await ApiService().updateProduct(Product(
                        id: widget.flavor.id,
                        name: _nameFlavorController.text,
                        imageUrl: _imageController.text,
                        description: _descController.text,
                        feature: _dopController.text,
                        price: price,
                        stock: widget.flavor.stock,
                      ));
                      Navigator.pop(context);
                      print("Информация товара обновлена");
                    } else {
                      print("Информация товара НЕ обновлена");
                    }
                  },
                  child: const Text(
                    "Сохранить",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
