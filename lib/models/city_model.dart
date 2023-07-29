class CityModel {
  int? id;
  String? name;
  String? imageUrl;
  bool? isPopular;

  CityModel({
    this.id,
    this.name,
    this.imageUrl,
    this.isPopular = false,
  });

  CityModel.fromJson(json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
  }
}
