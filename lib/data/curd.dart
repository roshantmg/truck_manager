import 'package:flutter/cupertino.dart';
import 'package:tipper_system/data/DBHelper.dart';
import 'package:tipper_system/models/bills.dart';
import 'package:tipper_system/models/material.dart';
import 'package:tipper_system/models/report.dart';
import 'package:tipper_system/models/sales.dart';
import 'package:tipper_system/models/supplier.dart';
import 'package:tipper_system/models/vehicle.dart';

class DataCollection extends ChangeNotifier {
  List<VehicleData> _vehicleList = [];
  Future<List<VehicleData>> getVehicleList() async {
    var result = await DB.query();
    if (result != null) {
      _vehicleList = result;
    }
    notifyListeners();
    return _vehicleList;
  }

  void insertVehicleData(VehicleData vehicleData) async {
    await DB.insert(vehicleData);
    await getVehicleList();
  }

  void removeVehicleData(VehicleData vehicleData) async {
    await DB.delete(vehicleData);
    await getVehicleList();
  }

  void updateVehicleData(VehicleData vehicleData) async {
    await DB.update(vehicleData);
    await getVehicleList();
  }

  //Supplier
  List<SupplierData> _supplierList = [];
  Future<List<SupplierData>> getSupplierList() async {
    var result = await DB.querySupplier();
    if (result != null) {
      _supplierList = result;
    }
    notifyListeners();
    return _supplierList;
  }

  void insertSupplierData(SupplierData supplierData) async {
    await DB.insertSupplier(supplierData);
    await getSupplierList();
  }

  void removeSupplierData(SupplierData supplierData) async {
    await DB.deleteSupplier(supplierData);
    await getSupplierList();
  }

  void updateSupplierData(SupplierData supplierData) async {
    await DB.updateSupplier(supplierData);
    await getSupplierList();
  }

  //Sales
  List<SalesData> _salesList = [];
  Future<List<SalesData>> getsalesList() async {
    var result = await DB.querySales();
    if (result != null) {
      _salesList = result;
    }
    notifyListeners();
    return _salesList;
  }

  void insertSalesData(SalesData salesData) async {
    await DB.insertSales(salesData);
    await getsalesList();
  }

  void removeSalesData(SalesData salesData) async {
    await DB.deleteSales(salesData);
    await getsalesList();
  }

  void updateSalesData(SalesData salesData) async {
    await DB.updateSales(salesData);
    await getsalesList();
  }

  //Bills
  List<BillData> _billList = [];
  Future<List<BillData>> getbillList() async {
    var result = await DB.queryBills();
    if (result != null) {
      _billList = result;
    }
    notifyListeners();
    return _billList;
  }

  void insertBillsData(BillData billData) async {
    await DB.insertBills(billData);
    await getbillList();
  }

  void removeBillsData(BillData billData) async {
    await DB.deleteBills(billData);
    await getbillList();
  }

  void updateBillsData(BillData billData) async {
    await DB.updateBills(billData);
    await getbillList();
  }

  //Materials
  List<MaterialData> _materialList = [];
  Future<List<MaterialData>> getMaterialList() async {
    var result = await DB.queryMaterial();
    if (result != null) {
      _materialList = result;
    }
    notifyListeners();
    return _materialList;
  }

  void insertMaterialData(MaterialData materialData) async {
    await DB.insertMaterial(materialData);
    await getMaterialList();
  }

  void removeMaterialData(MaterialData materialData) async {
    await DB.deleteMaterial(materialData);
    await getMaterialList();
  }

  void updateMaterialData(MaterialData materialData) async {
    await DB.updateMaterial(materialData);
    await getMaterialList();
  }

  //Report
  List<ReportData> _reportList = [];
  Future<List<ReportData>> getReportList() async {
    var result = await DB.queryReport();
    if (result != null) {
      _reportList = result;
    }
    notifyListeners();
    return _reportList;
  }

  void insertReportData(ReportData reportData) async {
    await DB.insertReport(reportData);
    await getReportList();
  }

  void removeReportData(ReportData reportData) async {
    await DB.deleteReport(reportData);
    await getReportList();
  }

  void updateReportData(ReportData reportData) async {
    await DB.updateReport(reportData);
    await getReportList();
  }
}
