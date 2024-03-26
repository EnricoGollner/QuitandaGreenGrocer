import 'package:get/get.dart';
import 'package:quitanda_app/src/core/utils/toast_util.dart';
import 'package:quitanda_app/src/models/category_model.dart';
import 'package:quitanda_app/src/pages/home/repositories/home_repository.dart';
import 'package:quitanda_app/src/pages/home/result/home_result.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();

  bool isLoading = false;
  List<CategoryModel> allCategories = [];
  CategoryModel? currentCategory;

  @override
  void onInit() {
    // Request the categories when the controller is initialized
    getAllCategories();
    super.onInit();
  }

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();
  }

  Future getAllCategories() async {
    _setLoading(true);
    final HomeResult<CategoryModel> homeResult = await _homeRepository.getAllCategories();

    _setLoading(false);

    homeResult.when(
      success: (data) {
        allCategories.addAll(data);
        if (allCategories.isEmpty) return;

        selectCategory(data.first);
      },
      error: (message) {
        FlutterToastUtil.show(message: message, isError: true);
      },
    );
  }
}
