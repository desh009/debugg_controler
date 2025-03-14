import 'dart:convert';

import 'package:debugg_controler/model/products.dart';
import 'package:debugg_controler/utils/utils.dart';
import 'package:debugg_controler/widgets/product_card.dart';
import 'package:http/http.dart' as http;


class ProductController {
  List<Data> products = [];

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse(Urls.readProduct));

    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ProductModel model = ProductModel.fromJson(data);
      products = model.data ?? [];
    }
  }


  Future<void> createProduct(String name,String img,int qty,int price,int totalPrice) async {
    final response = await http.post(Uri.parse(Urls.createProduct),
    headers: {'Content-Type' : 'application/json'},
      body: jsonEncode({
        "ProductName": name,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": img,
        "Qty": qty,
        "UnitPrice": price,
        "TotalPrice": totalPrice
      })
    );

    print(response);
    if (response.statusCode == 201) {
      fetchProducts();
    }
  }

  Future<void> UpdateProduct(String id,String name,String img,int qty,int price,int totalPrice) async {
    final response = await http.post(Uri.parse(Urls.updateProduct(id)),
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode({
          "ProductName": name,
          "ProductCode": DateTime.now().microsecondsSinceEpoch,
          "Img": img,
          "Qty": qty,
          "UnitPrice": price,
          "TotalPrice": totalPrice
        })
    );

    print(response);
    if (response.statusCode == 201) {
      fetchProducts();
    }
  }

  Future<bool> deleteProducts(String id) async {
    final response = await http.get(Uri.parse(Urls.deleteProduct(id)));

    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    }else{
      return false;
    }
  }
}