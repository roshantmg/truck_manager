class SalesData {
  int id;
  String salesDate;
  String materialName;
  String customerName;
  String quantity;
  String remarks;
  int saleAmount;

  SalesData(
      {this.id,
      this.salesDate,
      this.materialName,
      this.customerName,
      this.quantity,
      this.remarks,
      this.saleAmount});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'salesDate': this.salesDate,
      'materialName': this.materialName,
      'customerName': this.customerName,
      'quantity': this.quantity,
      'remarks': this.remarks,
      'saleAmount': this.saleAmount
    };
    return map;
  }
}
