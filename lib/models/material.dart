class MaterialData {
  int id;
  String materialName;
  String details;

  MaterialData({this.id, this.materialName, this.details});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'materialName': this.materialName,
      'details': this.details
    };
    return map;
  }
}
