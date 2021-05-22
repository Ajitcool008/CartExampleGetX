import 'package:cartdoodbleblue/src/controllers/home_controller.dart';
import 'package:cartdoodbleblue/src/elements/product_items.dart';
import 'package:cartdoodbleblue/src/views/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () {
          Get.to(CartScreen());
        },
        child: Container(
          alignment: Alignment.center,
          height: Get.height * 0.055,
          decoration: new BoxDecoration(
            color: Colors.indigo,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              SizedBox(width: Get.width * 0.01),
              Obx(
                () => Text(
                  "VIEW CART (${homeController.productCartCount} ITEMS)",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(children: <Widget>[
        // Background Image
        Container(
          height: Get.height * 0.28,
          width: Get.width,
          child: Image.network(
            'https://cdn-prod.medicalnewstoday.com/content/images/articles/316/316022/a-colorful-selection-of-fruits-and-vegetables.jpg',
            fit: BoxFit.fill,
          ),
        ),
        Container(
            margin:
                EdgeInsets.only(top: Get.height * 0.45, left: Get.width * 0.03),
            child: Text(
              "Starter",
              style: TextStyle(
                  fontSize: Get.width * 0.06, fontWeight: FontWeight.w500),
            )),
        Container(
            margin: EdgeInsets.only(top: Get.height * 0.5),
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                itemCount: homeController.productList.length,
                itemBuilder: (BuildContext context, int index) {
                  // Map post = posts[index];
                  return ProductItems(
                      homeController.productList[index], homeController);
                },
              ),
            )),
        //card with info
        Card(
            color: Colors.white,
            elevation: 1.0,
            margin: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
                top: Get.height * 0.2,
                bottom: Get.height * 0.47),
            child: Container(
              width: Get.width,
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: Get.height * 0.02),
                      child: Text(
                        "Inka Restaurant",
                        style: TextStyle(
                            fontSize: Get.width * 0.06,
                            fontWeight: FontWeight.w500),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: Get.height * 0.02),
                      child: Text(
                        "☆5.0(200+) | All days : 09:00 AM to 06:00 PM",
                        style: TextStyle(
                            fontSize: Get.width * 0.035, color: Colors.grey),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: Get.height * 0.01),
                      child: Text(
                        "📞 Reach us at : 9090783892",
                        style: TextStyle(
                            fontSize: Get.width * 0.035, color: Colors.grey),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: Get.height * 0.01),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text('Book a table'.toUpperCase()),
                      color: Colors.indigo,
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            )),

        // Positioned to take only AppBar size
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: [
              Icon(
                Icons.ios_share,
                color: Colors.white,
                size: Get.width * 0.08,
              ),
              SizedBox(
                width: Get.width * 0.03,
              ),
              Icon(
                Icons.help,
                color: Colors.white,
                size: Get.width * 0.08,
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}
