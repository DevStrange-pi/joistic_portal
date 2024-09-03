import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/company_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>AuthController(), fenix: true);
    Get.lazyPut(()=>CompanyController(), fenix: true);
  }
}
