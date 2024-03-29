import 'package:quitanda_app/src/constants/endpoints.dart';
import 'package:quitanda_app/src/models/category_model.dart';
import 'package:quitanda_app/src/models/item_model.dart';
import 'package:quitanda_app/src/pages/home/result/home_result.dart';
import 'package:quitanda_app/src/services/http_manager.dart';

class HomeRepository {
  final HTTPManager _httpManager = HTTPManager();

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final Map result = await _httpManager.restRequest(
      url: Endpoints.getAllCategories,
      method: HTTPMethods.post,
    );

    if (result['result'] != null) {
      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CategoryModel.fromJson)
              .toList();

      return HomeResult.success(data);
    } else {
      return HomeResult.error('Erro ao recuperar categorias!');
    }
  }

  Future<HomeResult<ItemModel>> getAllProducts({required Map<String, dynamic> body}) async {
    final Map result = await _httpManager.restRequest(
      url: Endpoints.getAllProducts,
      method: HTTPMethods.post,
      body: body,
    );
    
    if (result['result'] != null) {
      List<ItemModel> data = (List<Map<String, dynamic>>.from(result['result']))
          .map(ItemModel.fromJson)
          .toList();

      return HomeResult.success(data);
    } else {
      return HomeResult.error('Erro ao recuperar produtos');
    }
  }
}
