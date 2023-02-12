import 'package:care_me/Values/Preferences.dart';
import 'package:flutter/material.dart';

import '../Service/User.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ProfilePane(),
    );
  }
}

class ProfilePane extends StatefulWidget {
  const ProfilePane({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfilePane();
}

class _ProfilePane extends State<ProfilePane> {
  bool _userLoaded = false;
  bool _iAmCaregiver = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cellphoneController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  @override
  void initState() {
    // if ( !_userLoaded )
      {
        _loadUser();
        super.initState();

        // _userLoaded = true;
      }


  }

  _loadUser() async {
    User user = await Preferences.getUserData();

    _nameController.text = user.name!;
    _cellphoneController.text = user.cellphone!;
    _mailController.text = user.email!;
    _iAmCaregiver = user.caregiver!;
    _aboutController.text = user.about!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 150,
            child: Container(
              alignment: const Alignment(0.0, 1),
              child: const CircleAvatar(
                backgroundImage:
                    NetworkImage("https://source.unsplash.com/random?sig1"),
                radius: 60,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                label: const Text(
                  "Nome",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
            child: TextField(
              controller: _cellphoneController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                label: const Text(
                  "Telefone",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
            child: TextField(
              controller: _mailController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                label: const Text(
                  "Email",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: CheckboxListTile(
                title: const Text("Sou um cuidador",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.start),
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                onChanged: (value) {
                  setState(() {
                    _iAmCaregiver = value!;
                  });
                },
                value: _iAmCaregiver,
                activeColor: Colors.transparent),
          ),
          Visibility(
            visible: _iAmCaregiver,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
              child: TextField(
                controller: _aboutController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  label: Text(
                    "Sobre",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText:
                      "Fale sobre você e suas experiências profissionais.",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(10.0, 10.0),
                    ),
                  ),
                ),
                maxLength: 4000,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
