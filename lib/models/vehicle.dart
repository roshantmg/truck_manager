class VehicleData {
  int id;
  String vehicleType;
  String vehicleNo;
  String driverName;
  String driverContact;
  String helperName;
  String helperContact;
  String driverAddress;

  VehicleData(
      {this.id,
      this.vehicleType,
      this.vehicleNo,
      this.driverName,
      this.driverContact,
      this.helperName,
      this.helperContact,
      this.driverAddress});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'vehicleType': this.vehicleType,
      'vehicleNo': this.vehicleNo,
      'driverName': this.driverName,
      'driverContact': this.driverContact,
      'helperName': this.helperName,
      'helperContact': this.helperContact,
      'driverAddress': this.driverAddress
    };
    return map;
  }
}
