import 'package:flutter/material.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/product_model.dart';
import 'package:front/styles/add_item_styles.dart';

class AddFlavorScreen extends StatefulWidget {
  const AddFlavorScreen({super.key});

  @override
  _AddFlavorScreenState createState() => _AddFlavorScreenState();
}

class _AddFlavorScreenState extends State<AddFlavorScreen> {
  final TextEditingController _nameFlavorController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _dopController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Добавить новый автомобиль",
          style: TextStyle(
            color: Colors.black,
            fontSize: 21.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            TextField(
              controller: _nameFlavorController,
              decoration: InputDecoration(
                hintText: "Название модели",
                hintStyle: const TextStyle(
                  color: AppTheme.hintTextColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(
                hintText: "Ссылка на картинку",
                hintStyle: const TextStyle(
                  color: AppTheme.hintTextColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descController,
              decoration: InputDecoration(
                hintText: "Описание",
                hintStyle: const TextStyle(
                  color: AppTheme.hintTextColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _dopController,
              decoration: InputDecoration(
                hintText: "Дополнительная информация",
                hintStyle: const TextStyle(
                  color: AppTheme.hintTextColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                hintText: "Цена",
                hintStyle: const TextStyle(
                  color: AppTheme.hintTextColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                double price = double.parse(_priceController.text);

                if (_nameFlavorController.text.isNotEmpty &&
                    _imageController.text.isNotEmpty &&
                    _descController.text.isNotEmpty &&
                    _dopController.text.isNotEmpty &&
                    _priceController.text.isNotEmpty) {
                  await ApiService().createProduct(Product(
                    id: 100,
                    imageUrl: _imageController.text,
                    name: _nameFlavorController.text,
                    description: _descController.text,
                    feature: _dopController.text,
                    price: price,
                    stock: 0,
                  ));
                  Navigator.pop(context);
                  print("новый автомобиль создан");
                } else {
                  print("не все поля заполнены");
                }
              },
              child: const Text(
                "Сохранить",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
