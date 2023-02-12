import 'package:care_me/Service/UserService.dart';
import 'package:care_me/Utils/Preferences.dart';
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
  bool _iAmCaregiver = false;
  bool _editMode = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cellphoneController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  String _imageController = "";

  @override
  void initState() {
    _loadUser();
    super.initState();
  }

  _loadUser() async {
    User user = await Preferences.getUserData();

    _usernameController.text = user.username;
    _nameController.text = user.name!;
    _passwordController.text = user.password!;
    _cellphoneController.text = user.cellphone!;
    _mailController.text = user.email!;
    _iAmCaregiver = user.caregiver!;
    _aboutController.text = user.about!;
    _imageController = user.image!;
  }

// TODO: load profile image with base64 encoding
// TODO: user should be saved after changes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewInsets.bottom,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                child: Container(
                  alignment: const Alignment(0.0, 1),
                  child: const CircleAvatar(
                    backgroundImage:
                    NetworkImage("https://source.unsplash.com/random?sig1"),
                    radius: 75,
                  ),
                ),
              ),
              createTextFieldWidget(
                  "Nome de usuário", _usernameController, false),
              createTextFieldWidget("Senha", _passwordController, true),
              createTextFieldWidget("Nome", _nameController, false),
              createTextFieldWidget("Telefone", _cellphoneController, false),
              createTextFieldWidget("Email", _mailController, false),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: CheckboxListTile(
                    title: const Text("Sou um cuidador",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.start),
                    contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    onChanged: (value) {
                      setState(() {
                        if (_editMode) {
                          _iAmCaregiver = value!;
                        }
                      });
                    },
                    value: _iAmCaregiver,
                    activeColor: Colors.transparent),
              ),
              Flexible(
                child: Visibility(
                  visible: _iAmCaregiver,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      enabled: _editMode,
                      controller: _aboutController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        label: Text(
                          "Sobre",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
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
                      maxLength: 1500,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !_editMode,
                child: ElevatedButton(
                  child: const Text(
                    "Editar",
                  ),
                  onPressed: () {
                    setState(() => _editMode = !_editMode);
                  },
                ),
              ),
              Visibility(
                visible: _editMode,
                child: Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      child: Center(
                        child: ElevatedButton(
                          child: const Text("Cancelar"),
                          onPressed: () {
                            setState(() {
                              _cancelUpdateProfile();
                              _editMode = !_editMode;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ElevatedButton(
                          child: const Text("Salvar"),
                          onPressed: () {
                            setState(() {
                              _updateProfile();
                              _editMode = !_editMode;
                            });
                          },
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _cancelUpdateProfile() async {
    User userLogged = await Preferences.getUserData();

    _usernameController.text = userLogged.username;
    _nameController.text = userLogged.name!;
    _passwordController.text = userLogged.password!;
    _mailController.text = userLogged.email!;
    _cellphoneController.text = userLogged.cellphone!;
    _aboutController.text = userLogged.about!;
    _iAmCaregiver = userLogged.caregiver!;
    _imageController = userLogged.image!;
  }

  void _updateProfile() async {
    User userLogged = await Preferences.getUserData();

    User user = User(
      id: userLogged.id,
      username: _usernameController.text,
      name: _nameController.text,
      password: _passwordController.text,
      email: _mailController.text,
      cellphone: _cellphoneController.text,
      about: _aboutController.text,
      caregiver: _iAmCaregiver,
      image: _imageController,
    );

    UserService().updateUser(user);

    Preferences.saveUserData(user);
  }

  createTextFieldWidget(
      String label, TextEditingController controller, bool showText) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
      child: TextField(
        controller: controller,
        obscureText: showText,
        enabled: _editMode,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          label: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 18),
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
    );
  }
}
