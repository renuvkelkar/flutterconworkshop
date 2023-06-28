class CatModel {
  CatModel({
    this.name,
  });

  late final String? name;

  CatModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
