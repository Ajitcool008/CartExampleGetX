import 'package:cartdoodbleblue/src/models/cart_data.dart';

class ProductRepository {
  static List<ProductData> fetchAllProducts() {
    return [
      ProductData(
          id: 0,
          name: "Noodles",
          price: "20",
          packageItemsCount: 0,
          description: "Biona Organic Noodles"),
      ProductData(
          id: 1,
          name: "Pasta",
          packageItemsCount: 0,
          price: "30",
          description: "Organic Pasta"),
      ProductData(
          id: 2,
          name: "Banana",
          price: "10",
          packageItemsCount: 0,
          description: "Organic Spelt Banana"),
      ProductData(
          id: 3,
          name: "Sugar",
          price: "20",
          packageItemsCount: 0,
          description: "Organic Spelt Sugar"),
      ProductData(
          id: 4,
          name: "Sugar",
          price: "20",
          packageItemsCount: 0,
          description: "Organic Spelt Sugar"),
      ProductData(
          id: 5,
          name: "Sugar",
          price: "20",
          packageItemsCount: 0,
          description: "Organic Spelt Sugar"),
    ];
  }
}
