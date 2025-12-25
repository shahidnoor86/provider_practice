class Product {
  String? id;
  String? name;
  Data? data;

  Product({this.id, this.name, this.data});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? color;
  String? capacity;

  Data({this.color, this.capacity});

  Data.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    capacity = json['capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = color;
    data['capacity'] = capacity;
    return data;
  }
}
