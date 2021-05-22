import 'package:cartdoodbleblue/src/controllers/home_controller.dart';
import 'package:cartdoodbleblue/src/elements/product_items.dart';
import 'package:cartdoodbleblue/src/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAll(HomeScreen());
        return Future.value(true); // if true allow back else block it
      },
      child: SafeArea(
          child: Scaffold(
        bottomNavigationBar: Container(
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
              Text(
                "PLACE ORDER",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        body: Stack(children: <Widget>[
          // Background Image
          Container(
            height: Get.height * 0.32,
            width: Get.width,
            color: Colors.indigo,
          ),
          Container(
              margin: EdgeInsets.only(
                  top: Get.height * 0.35, left: Get.width * 0.03),
              child: Text(
                "Starter",
                style: TextStyle(
                    fontSize: Get.width * 0.06, fontWeight: FontWeight.w500),
              )),
          Container(
              margin: EdgeInsets.only(top: Get.height * 0.4),
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: homeController.showMore.value == 1
                          ? Get.height * 0.2
                          : Get.height * 0.5,
                      child: ListView.builder(
                        shrinkWrap: true,
                        // physics: ScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: homeController.productCartList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductItems(
                              homeController.productCartList[index],
                              homeController);
                        },
                      ),
                    ),
                    if (homeController.showMore.value == 1)
                      InkWell(
                        onTap: () {
                          homeController.hideMore();
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: Get.width * 0.04),
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Show More",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            )),
                      )
                  ],
                ),
              )),
          //card with info
          Card(
              color: Colors.white,
              elevation: 1.0,
              margin: EdgeInsets.only(
                  left: Get.width * 0.22,
                  right: Get.width * 0.22,
                  top: Get.height * 0.15,
                  bottom: Get.height * 0.65),
              child: Container(
                width: Get.width,
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: Get.height * 0.02),
                        child: Text(
                          "Total Cost",
                          style: TextStyle(
                              fontSize: Get.width * 0.06,
                              color: Colors.yellow,
                              fontWeight: FontWeight.w500),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: Get.height * 0.02),
                        child: Obx(() => Text(
                              "€${homeController.totalAmount.value}",
                              style: TextStyle(
                                  fontSize: Get.width * 0.035,
                                  color: Colors.grey),
                            ))),
                  ],
                ),
              )),

          // Positioned to take only AppBar size
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.offAll(HomeScreen()),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text("My Cart"),
            ),
          ),
        ]),
      )),
    );
  }
}
