class ReportData {
  int id;
  String reportNo;
  String reportDate;
  String vehicleNo;
  String materialName;
  String allowance;

  ReportData(
      {this.id,
      this.reportNo,
      this.reportDate,
      this.vehicleNo,
      this.materialName,
      this.allowance});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'reportNo': this.reportNo,
      'reportDate': this.reportDate,
      'vehicleNo': this.vehicleNo,
      'materialName': this.materialName,
      'allowance': this.allowance
    };
    return map;
  }
}
