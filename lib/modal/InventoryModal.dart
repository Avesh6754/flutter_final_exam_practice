class Inventorymodal {
   int? id;
  late String name, category, supplier;
  var quantity;
  late String time;

  Inventorymodal(
      {required this.name,
    this.id,
      required this.category,
      required this.time,
      required this.quantity,
      required this.supplier});

  factory Inventorymodal.fromMap(Map m1) {
    return Inventorymodal(
        name: m1['name'],
        id: m1['id'],
        category: m1['category'],
        time: m1['time'],
        quantity: m1['quantity'],
        supplier: m1['supplier']);
  }

}
Map<String, Object?> toMap(Inventorymodal item) {
  return {
    'name': item.name,
    'category': item.category,
    'time': item.time,
    'id':item.id,
    'quantity': item.quantity,
    'supplier': item.supplier,
  };
}


