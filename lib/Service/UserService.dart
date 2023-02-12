import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'User.dart';

class UserService {
  static const String host = "192.168.128.1:8080";
  static const Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<http.Response> doGetRequest(String endpoint) async {
    return await http.get(Uri.http(host, endpoint));
  }

  Future<http.Response> doPostRequest(String endpoint, String json) async {
    return await http.post(Uri.http(host, endpoint), body: json, headers: headers );
  }

  Future<http.Response> getUsers() async {
    return doGetRequest('/api/v1/get/users');
  }

  Future<User?> getUserByUsername(username) async {
    http.Response response =
        await doGetRequest('/api/v1/get/user/username/$username');

    if (response.statusCode == HttpStatus.ok) {
      var decoded = json.decode(response.body);

      return User.fromJson(decoded);
    }

    return null;
  }

  Future<User?> loginUser(String username, String password) async
  {
    String jsonFile = json.encode(User(id: null,
        username: username,
        name: null,
        password: password,
        email: null,
        cellphone: null,
        about: null,
        caregiver: null,
        image: null));

    http.Response response =
    await doPostRequest('/api/v1/login', jsonFile);

    if (response.statusCode == HttpStatus.ok) {
      var decoded = json.decode(response.body);

      return User.fromJson(decoded);
    }

    return null;
  }
}
