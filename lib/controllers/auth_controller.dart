import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final storage = GetStorage();
  var sesionIniciada = false.obs;

  @override
  void onInit() {
    super.onInit();
    sesionIniciada.value = storage.hasData('user');
  }

  void login(String email, String password) {
    storage.write('user', {'email': email});
    sesionIniciada.value = true;
    Get.offAllNamed('/home');
  }

  void logout() {
    storage.erase();
    sesionIniciada.value = false;
    Get.offAllNamed('/login');
  }
}
