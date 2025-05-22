import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note/app/widgets/show_global_snackbar.dart';

import '../../../data/enums/snackbar_type.dart';
import '../../../data/services/auth_repository.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var loginObscureText = true.obs;
  var registerObscureText = true.obs;

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final emailR = TextEditingController();
  final passwordR = TextEditingController();

  final AuthRepository _authRepo = AuthRepository();

  final emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  final passwordRegExp = RegExp(r'^.{6,}$');

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    password.dispose();
    emailR.dispose();
    passwordR.dispose();
    super.onClose();
  }

  Future<void> register({required VoidCallback onSuccess}) async {
    final nameText = name.text.trim();
    final emailText = emailR.text.trim();
    final passwordText = passwordR.text.trim();

    if (nameText.isEmpty || emailText.isEmpty || passwordText.isEmpty) {
      showGlobalSnackbar('All fields are required.', SnackbarType.error);
      return;
    }

    if (!emailRegExp.hasMatch(emailText)) {
      showGlobalSnackbar(
        'Please enter a valid email address.',
        SnackbarType.error,
      );
      return;
    }

    if (!passwordRegExp.hasMatch(passwordText)) {
      showGlobalSnackbar(
        'Password must be at least 6 characters long.',
        SnackbarType.error,
      );
      return;
    }

    try {
      isLoading(true);
      await _authRepo.signUp(
        name: nameText,
        email: emailText,
        password: passwordText,
      );
      showGlobalSnackbar('Registration successful! 🎉', SnackbarType.success);
      onSuccess();
    } catch (e) {
      showGlobalSnackbar(
        'Registration failed: ${e.toString()}',
        SnackbarType.error,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> login({required VoidCallback onSuccess}) async {
    final emailText = email.text.trim();
    final passwordText = password.text.trim();

    if (emailText.isEmpty || passwordText.isEmpty) {
      showGlobalSnackbar(
        'Email and password cannot be empty.',
        SnackbarType.error,
      );
      return;
    }

    if (!emailRegExp.hasMatch(emailText)) {
      showGlobalSnackbar(
        'Please enter a valid email address.',
        SnackbarType.error,
      );
      return;
    }

    if (!passwordRegExp.hasMatch(passwordText)) {
      showGlobalSnackbar(
        'Password must be at least 6 characters long.',
        SnackbarType.error,
      );
      return;
    }

    try {
      isLoading(true);
      await _authRepo.signIn(email: emailText, password: passwordText);
      onSuccess();
      showGlobalSnackbar('Login successful! 🎉', SnackbarType.success);
    } catch (e) {
      showGlobalSnackbar('Login failed: ${e.toString()}', SnackbarType.error);
    } finally {
      isLoading(false);
    }
  }
}
