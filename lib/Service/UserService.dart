import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'User.dart';

class UserService {
  static const String host = "192.168.128.1:8080";
  static const Map<String, String> headers = {
    'Content-Type': 'application/json'
  };
  static const timeout = 5;

  Future<http.Response> doGetRequest(String endpoint) async {
    return await http
        .get(Uri.http(host, endpoint))
        .timeout(const Duration(seconds: timeout));
  }

  Future<http.Response> doPostRequest(String endpoint, String json) async {
    return await http
        .post(Uri.http(host, endpoint), body: json, headers: headers)
        .timeout(const Duration(seconds: timeout));
  }

  Future<http.Response> doPutRequest(String endpoint, String json) async {
    return await http
        .put(Uri.http(host, endpoint), body: json, headers: headers)
        .timeout(const Duration(seconds: timeout));
  }

  Future<http.Response> getUsers() async {
    return doGetRequest('/api/v1/get/users');
  }

  Future<User?> getUserByUsername(username) async {
    http.Response response =
        await doGetRequest('/api/v1/get/user/username/$username');

    if (response.statusCode == HttpStatus.ok) {
      return User.fromJson(json.decode(response.body));
    }

    return null;
  }

  Future<int> updateUser(User newUser) async {
    String jsonFile = json.encode(User(
        id: newUser.id,
        username: newUser.username,
        name: newUser.name,
        password: newUser.password,
        email: newUser.email,
        cellphone: newUser.cellphone,
        about: newUser.about,
        caregiver: newUser.caregiver,
        image: newUser.image));

    http.Response response =
        await doPutRequest('/api/v1/update/user/${newUser.id}', jsonFile);

    if (response.statusCode == HttpStatus.ok) {
      return HttpStatus.ok;
    } else {
      return HttpStatus.badRequest;
    }
  }

  Future<User?> loginUser(String username, String password) async {
    String jsonFile = json.encode(User(
        id: null,
        username: username,
        name: null,
        password: password,
        email: null,
        cellphone: null,
        about: null,
        caregiver: null,
        image: null));

    http.Response response = await doPostRequest('/api/v1/login', jsonFile);

    if (response.statusCode == HttpStatus.ok) {
      return User.fromJson(json.decode(response.body));
    }

    return null;
  }
}
