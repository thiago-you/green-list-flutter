class Plant {
  int? id;
  String? name;
  String? scientificName;
  String? otherName;
  String? cycle;
  String? watering;
  String? sunlight;
  String? image;
  String? thumbnail;

  Plant({
    this.id,
    this.name,
    this.scientificName,
    this.otherName,
    this.cycle,
    this.watering,
    this.sunlight,
    this.image,
    this.thumbnail
  });

  Plant.fromJson(Map<String, dynamic> json) {
    id = json['title'];
    name = json['common_name'];
    scientificName = json['scientific_name'].isEmpty ? null : json['scientific_name'][0];
    otherName = json['other_name'].isEmpty ? null : json['other_name'][0];
    cycle = json['cycle'];
    watering = json['watering'];
    sunlight = json['sunlight'].isEmpty ? null : json['sunlight'][0];
    image = json['default_image']?['original_url'] ?? "";
    thumbnail = json['default_image']?['thumbnail'] ?? "";
  }

  @override
  String toString() {
    return 'Plant{id: $id, name: $name, scientificName: $scientificName, otherName: $otherName, cycle: $cycle, watering: $watering, sunlight: $sunlight, image: $image, thumbnail: $thumbnail}';
  }
}