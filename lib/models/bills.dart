class BillData {
  int id;
  String billDate;
  String billNo;
  String customerName;
  String amount;
  String materialName;
  String vehicleNo;
  String allowance;

  BillData(
      {this.id,
      this.billDate,
      this.billNo,
      this.customerName,
      this.amount,
      this.materialName,
      this.vehicleNo,
      this.allowance});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'billDate': billDate,
      'billNo': billNo,
      'customerName': customerName,
      'amount': amount,
      'materialName': materialName,
      'vehicleNo': vehicleNo,
      'allowance': allowance
    };
    return map;
  }
}
