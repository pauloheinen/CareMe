import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

// pub.dev/packages/motion_toast/versions/2.6.5
// https://codesinsider.com/flutter-styled-motion-toast-example-tutorial/
class ToastUtil {

  static void noConnectionToast( BuildContext context ) {
    MotionToast(
        primaryColor: Colors.grey,
        description: const Text("Sem conexão"),
        icon: Icons.wifi_off,
        animationDuration: const Duration(seconds: 5),
        position: MotionToastPosition.top,
        animationType: AnimationType.fromTop,

    ).show(context);
  }

  static void userNotFoundToast( BuildContext context ) {
    MotionToast(
        primaryColor: Colors.red,
        description: const Text("Usuário não encontrado"),
        icon: Icons.person_off_rounded,
        animationDuration: const Duration(seconds: 5),
        position: MotionToastPosition.top,
        animationType: AnimationType.fromTop
    ).show(context);
  }

  static void saveConfigurationsToast( BuildContext context ) {
    MotionToast(
        primaryColor: Colors.blue,
        description: const Text("Alterações salvas"),
        icon: Icons.save,
        animationDuration: const Duration(seconds: 5),
        position: MotionToastPosition.top,
        animationType: AnimationType.fromTop
    ).show(context);
  }

  static void cancelConfigurationsToast( BuildContext context ) {
    MotionToast(
        primaryColor: Colors.blue,
        description: const Text("Alterações canceladas"),
        icon: Icons.person_off_rounded,
        animationDuration: const Duration(seconds: 5),
        position: MotionToastPosition.top,
        animationType: AnimationType.fromTop
    ).show(context);
  }

}