import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/utils/auth.dart';
import 'package:flutter_api_rest/utils/dialogs.dart';
import 'package:meta/meta.dart';

class MyAPI {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://meedu-app-curso-api-jwt-flutter.vercel.app'),
  );

  Future<void> register(
    BuildContext context, {
    @required String username,
    @required String email,
    @required String password,
  }) async {
    final ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      final Response response = await this._dio.post(
        '/api/v1/register',
        data: {
          "username": username,
          "email": email,
          "password": password,
        },
      );
      await Auth.instance.setSession(response.data);
      progressDialog.dismiss();

      Navigator.pushNamedAndRemoveUntil(
        context,
        HomePage.routeName,
        (_) => false,
      );
    } catch (e) {
      progressDialog.dismiss();
      if (e is DioError) {
        print(e.response.statusCode);
        print(e.response.data);
        Dialogs.info(
          context,
          title: "ERROR",
          content: e.response.statusCode == 409
              ? 'Duplicated email or username'
              : e.message,
        );
      } else {
        print(e);
      }
    }
  }

  Future<void> login(
    BuildContext context, {
    @required String email,
    @required String password,
  }) async {
    final ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      final Response response = await this._dio.post(
        '/api/v1/login',
        data: {
          "email": email,
          "password": password,
        },
      );

      await Auth.instance.setSession(response.data);
      progressDialog.dismiss();

      Navigator.pushNamedAndRemoveUntil(
        context,
        HomePage.routeName,
        (_) => false,
      );
    } catch (e) {
      progressDialog.dismiss();
      if (e is DioError) {
        print(e.response.statusCode);
        print(e.response.data);
        String message = e.message;
        if (e.response.statusCode == 404) {
          message = "User not found";
        } else if (e.response.statusCode == 403) {
          message = "Invalid password";
        }

        Dialogs.info(
          context,
          title: "ERROR",
          content: message,
        );
      } else {
        print(e);
      }
    }
  }

  Future<dynamic> refresh(String expiredToken) async {
    try {
      final Response response = await this._dio.post(
            '/api/v1/refresh-token',
            options: Options(headers: {
              'token': expiredToken,
            }),
          );
      return response.data;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
