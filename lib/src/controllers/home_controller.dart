import 'package:cartdoodbleblue/src/helpers/db_provider.dart';
import 'package:cartdoodbleblue/src/models/cart_data.dart';
import 'package:cartdoodbleblue/src/repository/product_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var productList = <ProductData>[].obs;
  var productCartList = <ProductData>[].obs;
  var productCartCount = 0.obs;
  var showMore = 0.obs;
  RxDouble totalAmount = 0.0.obs;

  @override
  void onInit() {
    fetchProduct();
    getUpdate();
    showMore.value = 0;
    totalAmount.value = 0.0;
    super.onInit();
  }

  void fetchProduct() async {
    var products = ProductRepository.fetchAllProducts();
    productList.value = products;
  }

  void getUpdate() {
    DBProvider.db.getCompleteCarts().then((value) {
      productCartCount.value = value.length;
    });
    getCartList();
  }

  void getCartList() {
    totalAmount.value = 0.0;
    DBProvider.db.getCarts().then((value) {
      productCartList.value = value;
      for (var i = 0; i < value.length; i++) {
        double addAmount = double.parse(value[i].price ?? "0");
        this.totalAmount = totalAmount + addAmount;
        print(totalAmount);
      }
      if (value.length > 2 && showMore.value == 0) {
        showMore.value = 1;
      }
    });
  }

  void hideMore() {
    showMore.value = 3;
  }
}
