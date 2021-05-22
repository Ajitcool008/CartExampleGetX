import 'package:cartdoodbleblue/src/controllers/home_controller.dart';
import 'package:cartdoodbleblue/src/helpers/db_provider.dart';
import 'package:cartdoodbleblue/src/models/cart_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductItems extends StatefulWidget {
  final ProductData productData;
  final HomeController homeController;
  ProductItems(this.productData, this.homeController);

  @override
  _ProductItemsState createState() => _ProductItemsState();
}

class _ProductItemsState extends State<ProductItems> {
  int _n = 0;

  void add() {
    //menuServiceModel.map
    //String userProfileJson = json.encode(menuServiceModel);
    if (_n >= 20) {
    } else {
      print('Inserting ${widget.productData}');
      DBProvider.db.createCarts(widget.productData).then((value) {
        setState(() {
          _n++;
        });
      });
      widget.homeController.getUpdate();
    }
    //DBProvider.db.createUsers(MenuServiceModel.fromJson(menuServiceModel));    });
  }

  void minus() {
    if (_n <= 0) {
    } else {
      print('Inserting ${widget.productData}');
      DBProvider.db.deleteCarts(widget.productData).then((e) {
        setState(() {
          _n--;
        });
      });
      widget.homeController.getUpdate();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DBProvider.db.getCarts().then((value) {
        setState(() {
          _n = value
              .firstWhere((element) => widget.productData.id == element.id)
              .packageItemsCount;
        });
      });
    });
  }

  Widget cartText(text, fontSize, color) {
    return Container(
        child: Text("$text",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: color,
                fontSize: fontSize)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 0.0),
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cartText("${widget.productData.name}", Get.width * 0.04,
                  Colors.black54),
              cartText("${widget.productData.description}", Get.width * 0.035,
                  Colors.black54),
              cartText("€${widget.productData.price}", Get.width * 0.04,
                  Colors.yellow),
            ],
          ),
          if (_n == 0) ...{
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Text('Add'.toUpperCase()),
              color: Colors.indigo,
              textColor: Colors.white,
              onPressed: add,
            ),
          } else
            Row(
              children: [
                InkWell(
                  onTap: minus,
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: new BoxDecoration(
                      color: Colors.orange[800],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.remove,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 8,
                          offset:
                              Offset(0.0, 5.0), // changes position of shadow
                        ),
                      ],
                      border: Border.all(color: Colors.grey[300])),
                  child: Text(
                    '$_n',
                    style: new TextStyle(fontSize: 22.0),
                  ),
                ),
                SizedBox(width: 8.0),
                InkWell(
                  onTap: add,
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: new BoxDecoration(
                      color: Colors.orange[800],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
        ]));
  }
}
