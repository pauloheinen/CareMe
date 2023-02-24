import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/User.dart';

class UserUtil {
  static ImageProvider loadUserProfileImage(User user) {
    if (user.image == null || user.image == "null") {
      return Image.asset("lib/Resources/default-profile-photo.png").image;
    } else {
      return Image.memory(const Base64Decoder().convert(user.image!)).image;
    }
  }
}
