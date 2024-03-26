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

  RxString searchTitle = ''.obs;

  bool get isLastPage {
    if (currentCategory!.items.length < itemsPerPage) {
      return true;
    }
    return currentCategory!.pagination * itemsPerPage > allProducts.length;
  }

  @override
  void onInit() {
    // Request the categories when the controller is initialized
    // Listen for changes on searchTitle and execute the callback method when it's value's changed.
    debounce(searchTitle, (_) async => await filterByTitle());

    getAllCategories();

    super.onInit();
  }

  void _setLoading(bool value, {bool isProduct = false}) {
    isProduct ? isProductLoading = value : isCategoryLoading = value;
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
    final HomeResult<CategoryModel> homeResult =
        await _homeRepository.getAllCategories();

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

  Future<void> getAllProducts({bool canLoad = true}) async {
    if (canLoad) _setLoading(true, isProduct: true);

    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itemsPerPage': itemsPerPage,
    };

    if (searchTitle.value.isNotEmpty) {
      body['title'] = searchTitle.value;

      if (currentCategory!.id.isEmpty) { // Verifying if the current category is the one with all products (created with empty id)
        body.remove('categoryId');
      }
    }

    final HomeResult<ItemModel> result = await _homeRepository.getAllProducts(body: body);
    _setLoading(false, isProduct: true);

    result.when(
      success: (data) {
        currentCategory!.items.addAll(data);
      },
      error: (message) {
        FlutterToastUtil.show(message: message, isError: true);
      },
    );
  }

  Future<void> filterByTitle() async {
    // Apagar todos os produtos das categorias
    for (var category in allCategories) {
      category.items.clear();
      category.pagination = 0;
    }

    if (searchTitle.value.isEmpty) {
      allCategories.removeAt(0);
    } else {
      CategoryModel? category = allCategories.firstWhereOrNull((category) => category.id == '');

      if (category == null) {
        // Criar uma nova categoria com todos
        final allProductsCategory = CategoryModel(
          title: 'Todos',
          id: '',
          items: [],
          pagination: 0,
        );

        allCategories.insert(0, allProductsCategory);
      } else {
        category.items.clear();
        category.pagination = 0;
      }
    }

    currentCategory = allCategories.first;
    update();
    await getAllProducts();
  }

  Future<void> loadMoreProducts() async {
    currentCategory!.pagination++;
    await getAllProducts(canLoad: false);
  }
}
