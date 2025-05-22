class BeltModel {
  String beltOrder;
  String name;
  String color;

  //construtor
  BeltModel({required this.beltOrder, required this.name, required this.color});

  BeltModel.toMap(Map<String, dynamic> map)
    : beltOrder = map["beltOrder"],
      name = map["name"],
      color = map["color"];

  Map<String, dynamic> toMap() {
    return {"beltOrder": beltOrder, "name": name, "color": color};
  }
}
