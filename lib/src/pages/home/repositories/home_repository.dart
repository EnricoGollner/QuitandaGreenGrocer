import 'package:quitanda_app/src/constants/endpoints.dart';
import 'package:quitanda_app/src/services/http_manager.dart';

class HomeRepository {
  final HTTPManager _httpManager = HTTPManager();

  Future getAllCategories() async {
    final Map result = await _httpManager.restRequest(url: Endpoints.getAllCategories, method: HTTPMethods.post);

    if (result['result'] != null) {

    } else {

    }
  }
}