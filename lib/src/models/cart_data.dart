class ProductData {
  ProductData({
    this.id,
    this.name,
    this.price,
    this.description,
    this.packageItemsCount,
  });

  int id;
  String name;
  String price;
  String description;
  int packageItemsCount;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? "" : json["name"],
        price: json["price"] == null ? '0' : json["price"].toString(),
        description: json["description"] == null ? "" : json["description"],
        packageItemsCount:
            json["packageItemsCount"] == null ? 0 : json["packageItemsCount"],
      );

  ProductData.fromDb(Map<String, dynamic> json) {
    id = json["id"] == null ? null : json["id"];
    name = json["name"] == null ? null : json["name"];
    price = json["price"] == null ? null : json["price"].toString();
    description = json["description"] == null ? "" : json["description"];
    packageItemsCount =
        json["packageItemsCount"] == null ? 0 : json["packageItemsCount"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "packageItemsCount": packageItemsCount,
      };
}
