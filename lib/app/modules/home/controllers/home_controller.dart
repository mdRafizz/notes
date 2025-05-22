import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note/app/data/services/auth_repository.dart';

class HomeController extends GetxController {

  final isLoading = false.obs;
  final _authRepo = AuthRepository();


  void signOut({required VoidCallback onSuccess}) async {
    try{
      isLoading(true);
      await _authRepo.signOut();
      onSuccess();
    }catch(e){

    }finally{
      isLoading(false);
    }
  }

}
