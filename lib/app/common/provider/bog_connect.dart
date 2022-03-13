import 'package:get/get.dart';

class BogConnect extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://bog.ac/api/';
    
  }
}
