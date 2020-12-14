class SupplierData {
  int id;
  String supplierName;
  String supplierAddress;
  String supplierContact;

  SupplierData(
      {this.id, this.supplierName, this.supplierAddress, this.supplierContact});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'supplierName': this.supplierName,
      'supplierAddress': this.supplierAddress,
      'supplierContact': this.supplierContact,
    };
    return map;
  }
}
