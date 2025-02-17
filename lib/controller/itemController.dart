import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_final_exam_practice/modal/InventoryModal.dart';
import 'package:flutter_final_exam_practice/services/dbHelper.dart';
import 'package:get/get.dart';

class ItemController extends GetxController {
  var txtName = TextEditingController();
  var txtQuantity = TextEditingController();
  var txtSupplier = TextEditingController();
  late RxString dateTime;
  RxList<Inventorymodal> localDataList = <Inventorymodal>[].obs;
  List<String> list = <String>['Electronics', 'Furniture', 'Clothing'];
  RxString category = 'Electronics'.obs;

  Future<RxList<Inventorymodal>> fetchDataFromLocal() async {
    List? data = await DbHelper.dbHelper.fetchData();
    localDataList.value = data
        .map(
          (e) => Inventorymodal.fromMap(e),
        )
        .toList();
    return localDataList;
  }
  Future<void> insertDataInLocal(Inventorymodal item) async {
    print("==========================${item.name}");
   await  DbHelper.dbHelper.insertData(item);
   await fetchDataFromLocal();
  }
}
