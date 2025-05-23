import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note/app/data/enums/snackbar_type.dart';
import 'package:note/app/data/services/auth_repository.dart';
import 'package:note/app/widgets/show_global_snackbar.dart';

class HomeController extends GetxController {

  final isLoading = false.obs;
  final _authRepo = AuthRepository();


  void signOut({required VoidCallback onSuccess}) async {
    try{
      isLoading(true);
      await _authRepo.signOut();
      onSuccess();
      showGlobalSnackbar('Logout successful!', SnackbarType.success);
    }catch(e){

    }finally{
      isLoading(false);
    }
  }

}
