import 'package:flutter/material.dart';
import 'package:flutter_final_exam_practice/controller/itemController.dart';
import 'package:flutter_final_exam_practice/modal/InventoryModal.dart';
import 'package:flutter_final_exam_practice/utils/global.dart';
import 'package:get/get.dart';

var itemController = Get.put(ItemController());

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Home Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(

        children: [
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...List.generate(itemController.list.length, (index)=>GestureDetector(
                onTap: () {

                },
                child: Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),

                    ),
                    alignment: Alignment.center,
                    child: Text(itemController.list[index],style: TextStyle(),)),
              )
              )
            ],
          ),
          SizedBox(height: 20,),
          Expanded(
            child: FutureBuilder(
              future: itemController.fetchDataFromLocal(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {}
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  List<Inventorymodal> itemList = snapshot.data!;
                  return Obx(
                    () => ListView.builder(
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              Text(itemList[index].name),
                              Text(itemList[index].category),
                              Text(itemList[index].supplier),
                              Text('${itemList[index].quantity}'),
                              Text(itemList[index].time),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  textField('Name', itemController.txtName),
                  SizedBox(
                    height: 10,
                  ),
                  textField('Supplier', itemController.txtSupplier),
                  SizedBox(
                    height: 10,
                  ),
                  textField('Quantity', itemController.txtQuantity),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => DropdownButton<String>(
                      value: itemController.category.value,
                      items: itemController.list
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        itemController.category.value = value!;
                      },
                    ),
                  ),
                ],
              ),
              actions: [

                TextButton(
                    onPressed: () {
                      itemController.txtQuantity.clear();
                      itemController.txtName.clear();
                      itemController.txtSupplier.clear();
                      Get.back();
                    },
                    child: Text('Cancel')),
                TextButton(onPressed: ()  async {
                  Inventorymodal item=Inventorymodal(name: itemController.txtName.text,  category: itemController.category.value, time:DateTime.now().toIso8601String(), quantity: itemController.txtQuantity.text, supplier:itemController.txtSupplier.text);
                 await itemController.insertDataInLocal(item);
                  Get.back();

                }, child: Text('Add')),
              ],
            ),
          );
        },
      ),
    );
  }
}

TextField textField(String hint, var controller) {
  return TextField(
      controller: controller,
      decoration:
          InputDecoration(hintText: hint, border: OutlineInputBorder()));
}
