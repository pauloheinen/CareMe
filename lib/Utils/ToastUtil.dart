import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';


// https://codesinsider.com/flutter-styled-motion-toast-example-tutorial/
class ToastUtil {

  static void noConnectionToast( BuildContext context ) {
    MotionToast(
        color: Colors.grey,
        description: "Sem conexão",
        icon: Icons.wifi_off,
        animationDuration: const Duration(seconds: 5),
        position: MOTION_TOAST_POSITION.TOP,
        animationType: ANIMATION.FROM_TOP,

    ).show(context);
  }

  static void userNotFoundToast( BuildContext context ) {
    MotionToast(
        color: Colors.red,
        description: "Usuário não encontrado",
        icon: Icons.person_off_rounded,
        animationDuration: const Duration(seconds: 5),
        position: MOTION_TOAST_POSITION.TOP,
        animationType: ANIMATION.FROM_TOP
    ).show(context);
  }

  static void saveConfigurationsToast( BuildContext context ) {
    MotionToast(
        color: Colors.blue,
        description: "Alterações salvas",
        icon: Icons.save,
        animationDuration: const Duration(seconds: 5),
        position: MOTION_TOAST_POSITION.TOP,
        animationType: ANIMATION.FROM_TOP
    ).show(context);
  }

  static void cancelConfigurationsToast( BuildContext context ) {
    MotionToast(
        color: Colors.blue,
        description: "Alterações canceladas",
        icon: Icons.person_off_rounded,
        animationDuration: const Duration(seconds: 5),
        position: MOTION_TOAST_POSITION.TOP,
        animationType: ANIMATION.FROM_TOP
    ).show(context);
  }

}