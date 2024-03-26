import 'package:get/get.dart';
import 'package:quitanda_app/src/core/utils/toast_util.dart';
import 'package:quitanda_app/src/models/category_model.dart';
import 'package:quitanda_app/src/models/item_model.dart';
import 'package:quitanda_app/src/pages/home/repositories/home_repository.dart';
import 'package:quitanda_app/src/pages/home/result/home_result.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();

  bool isCategoryLoading = false;
  bool isProductLoading = true;
  List<CategoryModel> allCategories = [];
  CategoryModel? currentCategory;
  List<ItemModel> get allProducts => currentCategory?.items ?? [];

  @override
  void onInit() { // Request the categories when the controller is initialized
    getAllCategories();
    super.onInit();
  }

  void _setLoading(bool value, {bool isProduct = false}) {
    isProduct
      ? isProductLoading = value
      : isCategoryLoading = value;
    update();
  }

  Future<void> selectCategory(CategoryModel category) async {
    currentCategory = category;
    update();

    if (currentCategory!.items.isNotEmpty) return;

    await getAllProducts();
  }

  Future getAllCategories() async {
    _setLoading(true);
    final HomeResult<CategoryModel> homeResult = await _homeRepository.getAllCategories();

    _setLoading(false);

    homeResult.when(
      success: (data) async {
        allCategories.addAll(data);
        if (allCategories.isEmpty) return;
        await selectCategory(data.first);
      },
      error: (message) {
        FlutterToastUtil.show(message: message, isError: true);
      },
    );
  }

  Future<void> getAllProducts() async {
    _setLoading(true, isProduct: true);
    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itemsPerPage': itemsPerPage,
    };

    final HomeResult<ItemModel> result = await _homeRepository.getAllProducts(body: body);
    _setLoading(false, isProduct: true);

    result.when(
      success: (data) {
        currentCategory!.items = data;
      },
      error: (message) {
        FlutterToastUtil.show(message: message, isError: true);
      },
    );
  }
}
