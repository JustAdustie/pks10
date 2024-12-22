import 'package:flutter/material.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/user_model.dart';
import 'package:front/styles/edit_user_styles.dart';

class MyEditUserInfoPage extends StatefulWidget {
  const MyEditUserInfoPage({super.key, required this.uinfo});
  final User uinfo;

  @override
  State<MyEditUserInfoPage> createState() => _MyEditUserInfoPageState();
}

class _MyEditUserInfoPageState extends State<MyEditUserInfoPage> {
  late Future<User> user;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _profilePicController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ApiService().getUserById(widget.uinfo.id).then((i) => {
      _userNameController.text = i.name,
      _profilePicController.text = i.image,
      _emailController.text = i.email,
      _phoneController.text = i.phoneNumber
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _profilePicController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Изменение данных профиля",
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
                  'Имя пользователя',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.labelColor,
                  ),
                ),
              ),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  hintText: 'Имя пользователя',
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Фото профиля',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.labelColor,
                  ),
                ),
              ),
              TextField(
                controller: _profilePicController,
                decoration: InputDecoration(
                  hintText: 'ссылка на фото профиля',
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Почта',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.labelColor,
                  ),
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'почта',
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Телефон',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.labelColor,
                  ),
                ),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  hintText: 'телефон',
                ),
              ),
              const SizedBox(height: 60),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_userNameController.text.isNotEmpty &&
                        _profilePicController.text.isNotEmpty &&
                        _emailController.text.isNotEmpty &&
                        _phoneController.text.isNotEmpty) {
                      await ApiService().updateUser(User(
                        id: widget.uinfo.id,
                        image: _profilePicController.text,
                        name: _userNameController.text,
                        email: _emailController.text,
                        phoneNumber: _phoneController.text,
                        password: widget.uinfo.password,
                      ));
                      Navigator.pop(context);
                      print("Информация профиля обновлена");
                    } else {
                      print("Информация профиля НЕ обновлена");
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
