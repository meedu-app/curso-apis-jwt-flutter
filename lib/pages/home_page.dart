import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/logs.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_api_rest/api/account_api.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/models/user.dart';
import 'package:flutter_api_rest/pages/login_page.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authenticationClient = GetIt.instance<AuthenticationClient>();
  final _accountAPI = GetIt.instance<AccountAPI>();

  User _user;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUser();
    });
  }

  Future<void> _loadUser() async {
    final response = await _accountAPI.getUserInfo();
    if (response.data != null) {
      _user = response.data;
      setState(() {});
    }
  }

  Future<void> _signOut() async {
    await _authenticationClient.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginPage.routeName,
      (_) => false,
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final PickedFile pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final filename = path.basename(pickedFile.path);
      final response = await _accountAPI.updateAvatar(bytes, filename);
      if (response.data != null) {
        _user = _user.copyWith(avatar: response.data);
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_user == null) CircularProgressIndicator(),
            if (_user != null)
              Column(
                children: [
                  if (_user.avatar != null)
                    ClipOval(
                      child: Image.network(
                        "https://curso-api-flutter.herokuapp.com${_user.avatar}",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Text(_user.id),
                  Text(_user.username),
                  Text(_user.email),
                  Text(
                    _user.createdAt.toIso8601String(),
                  ),
                ],
              ),
            SizedBox(height: 30),
            FlatButton(
              onPressed: _pickImage,
              child: Text("Update avatar"),
            ),
            FlatButton(
              onPressed: _signOut,
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}
