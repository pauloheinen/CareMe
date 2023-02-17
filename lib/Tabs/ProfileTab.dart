import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:care_me/Service/UserService.dart';
import 'package:care_me/Utils/Preferences.dart';
import 'package:care_me/Utils/ToastUtil.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

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
  bool _isLoaded = false;

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

    setState(() {
      _isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded == false
        ? const CircularProgressIndicator()
        : Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewInsets.bottom,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Container(
                  height: 160,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          backgroundImage: Image.memory(
                              const Base64Decoder()
                                  .convert(_imageController))
                              .image,
                          radius: 85,
                        ),
                      ),
                      Visibility(
                        visible: _editMode,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: IconButton(
                            padding:
                            const EdgeInsets.fromLTRB(85, 25, 0, 0),
                            enableFeedback: false,
                            iconSize: 40,
                            icon: const Icon(Icons.camera_alt),
                            splashColor: Colors.transparent,
                            onPressed: () {
                              changePhoto();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              createTextFieldWidget(
                  "Nome de usuário", _usernameController, false),
              createTextFieldWidget("Senha", _passwordController, true),
              createTextFieldWidget("Nome", _nameController, false),
              createTextFieldWidget(
                  "Telefone", _cellphoneController, false),
              createTextFieldWidget("Email", _mailController, false),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: CheckboxListTile(
                    title: const Text("Sou um cuidador",
                        style:
                        TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.start),
                    contentPadding:
                    const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                          style: TextStyle(
                              color: Colors.white, fontSize: 20),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        floatingLabelBehavior:
                        FloatingLabelBehavior.always,
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

    setState(() {});
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

    int httpStatus = await UserService().updateUser(user);

    if (httpStatus == HttpStatus.ok) {
      Preferences.saveUserData(user);
      ToastUtil.saveConfigurationsToast(context);
    } else {
      ToastUtil.cancelConfigurationsToast(context);
    }

    initState();
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

  changePhoto() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: const EdgeInsets.only(top: 10.0),
          content: SizedBox(
            width: 800.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text(
                      "Selecionar foto",
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  color: Colors.grey,
                  height: 5,
                  thickness: 1,
                ),
                SizedBox(
                  height: 110,
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                const Text(
                                  "Galeria",
                                  style: TextStyle(fontSize: 18),
                                ),
                                IconButton(
                                  splashColor: Colors.transparent,
                                  enableFeedback: false,
                                  iconSize: 50,
                                  icon: const Icon(Icons.image_rounded),
                                  onPressed: () async {
                                    await accessGallery();
                                    setState(() {});
                                    // Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                const Text(
                                  "Câmera",
                                  style: TextStyle(fontSize: 18),
                                ),
                                IconButton(
                                  splashColor: Colors.transparent,
                                  enableFeedback: false,
                                  iconSize: 50,
                                  icon: const Icon(Icons.camera_alt),
                                  onPressed: () async {
                                    await accessCamera();
                                    setState(() {});
                                    // Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> accessGallery() async {
    XFile? recordedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    String path = recordedImage!.path;

    setState(() {
      var encodedFile = base64Encode(File(path).readAsBytesSync());
      _imageController = encodedFile;
    });
  }

  Future<void> accessCamera() async {
    XFile? recordedImage =
    await ImagePicker().pickImage(source: ImageSource.camera);

    String path = recordedImage!.path;
    GallerySaver.saveImage(path);

    setState(() {
      var encodedFile = base64Encode(File(path).readAsBytesSync());
      _imageController = encodedFile;
    });
  }
}
