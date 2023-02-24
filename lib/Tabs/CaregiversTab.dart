import 'dart:async';
import 'dart:convert';

import 'package:care_me/Utils/UserUtil.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../Models/User.dart';
import '../Service/UserService.dart';
import '../Utils/Preferences.dart';
import '../Utils/ToastUtil.dart';

class CaregiverView extends StatelessWidget {
  const CaregiverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CaregiverPane(),
    );
  }
}

class CaregiverPane extends StatefulWidget {
  const CaregiverPane({Key? key}) : super(key: key);

  @override
  createState() => _CaregiverPane();
}

class _CaregiverPane extends State<CaregiverPane> {
  bool _isLoaded = false;

  late List<User> listOfUsers;

  @override
  void initState() {
    _loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded == false
        ? const CircularProgressIndicator()
        : Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewInsets.bottom,
          margin: const EdgeInsets.only(top: 16),
          child: ListView.builder(
              itemCount: listOfUsers.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final user = listOfUsers[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: ListTile(
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    tileColor: Colors.blue,
                    enableFeedback: false,
                    splashColor: Colors.transparent,
                    leading: AspectRatio(
                      aspectRatio: 1,
                      child: ClipOval(
                        child: Image(
                          image: UserUtil.loadUserProfileImage(user),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      user.name!,
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: Text("Cuidador: ${user.caregiver}",
                        style: const TextStyle(fontSize: 18)),
                    trailing: PopupMenuButton<int>(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blueGrey),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        elevation: 2,
                        onSelected: (value) {
                          if (value == 1) {
                            _openChat();
                          } else if (value == 2) {
                            _openProfile();
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                            value: 1,
                            child: Text("Abrir chat",
                                style: TextStyle(fontSize: 18)),
                          ),
                          const PopupMenuItem(
                            value: 2,
                            child: Text(
                              "Visualizar perfil",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ]),
                  ),
                );
              }),
        ),
      ),
    );
  }

  void _loadUsers() async {
    Response response;

    try {
      User user = await Preferences.getUserData();

      response = await UserService().getUsersButNot( user.id );
    } on TimeoutException catch (ignored) {
      ToastUtil.noConnectionToast(context);
      return;
    }

    Iterable l = json.decode(response.body);
    List<User> users = List<User>.from(l.map((model) => User.fromJson(model)));

    setState(() {
      listOfUsers = users;
      _isLoaded = true;
    });
  }

  _openChat() {}

  void _openProfile() {}
}
