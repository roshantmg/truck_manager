import 'package:sqflite/sqflite.dart';
import 'package:tipper_system/models/bills.dart';
import 'package:tipper_system/models/material.dart';
import 'package:tipper_system/models/report.dart';
import 'package:tipper_system/models/sales.dart';
import 'package:tipper_system/models/supplier.dart';
import 'package:tipper_system/models/vehicle.dart';

class DB {
  static Database _db;
  static int get _version => 2;
  static String vehicleTable = 'VEHICLE';
  static String supplierTable = 'SUPPLIER';
  static String salesTable = 'SALES';
  static String billsTable = 'BILLS';
  static String materialTable = 'MATERIAL';
  static String reportTable = 'REPORT';

  static Future<void> init() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() +
          'vehicle' +
          'supplier' +
          'sales' +
          'bills' +
          'material' +
          'report';
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (e) {
      print(e.toString());
    }
  }

  static void onCreate(Database db, int version) async {
    db.execute("CREATE TABLE $vehicleTable("
        "id INTEGER PRIMARY KEY,"
        "vehicleType TEXT,"
        "vehicleNo TEXT,"
        "driverName TEXT,"
        "driverContact TEXT,"
        "helperName TEXT,"
        "helperContact TEXT,"
        "driverAddress TEXT"
        ")");
    db.execute("CREATE TABLE $supplierTable("
        "id INTEGER PRIMARY KEY,"
        "supplierName TEXT,"
        "supplierAddress TEXT,"
        "supplierContact TEXT"
        ")");
    db.execute("CREATE TABLE $salesTable("
        "id INTEGER PRIMARY KEY,"
        "salesDate TEXT,"
        "materialName TEXT,"
        "customerName TEXT,"
        "quantity TEXT,"
        "remarks TEXT,"
        "saleAmount INTEGER"
        ")");
    db.execute("CREATE TABLE $billsTable("
        "id INTEGER PRIMARY KEY,"
        "billDate TEXT,"
        "billNo TEXT,"
        "customerName TEXT,"
        "amount TEXT,"
        "materialName TEXT,"
        "vehicleNo TEXT,"
        "allowance TEXT"
        ")");
    db.execute("CREATE TABLE $materialTable("
        "id INTEGER PRIMARY KEY,"
        "materialName TEXT,"
        "details TEXT"
        ")");
    db.execute("CREATE TABLE $reportTable("
        "id INTEGER PRIMARY KEY,"
        "reportNo TEXT,"
        "reportDate TEXT,"
        "vehicleNo TEXT,"
        "materialName TEXT,"
        "allowance TEXT"
        ")");
  }

  //Vehicle
  static Future<int> insert(VehicleData vehicleData) async {
    var table = await _db.rawQuery("SELECT MAX(id)+1 as id from $vehicleTable");
    int id = table.first['id'];
    var raw = await _db.rawInsert(
        "INSERT INTO $vehicleTable(id,vehicleType,vehicleNo,driverName,driverContact,helperName,helperContact,driverAddress)"
        "VALUES(?,?,?,?,?,?,?,?)",
        [
          id,
          vehicleData.vehicleType,
          vehicleData.vehicleNo,
          vehicleData.driverName,
          vehicleData.driverContact,
          vehicleData.helperName,
          vehicleData.helperContact,
          vehicleData.driverAddress
        ]);
    return raw;
  }

  static Future<List<VehicleData>> query() async {
    List<VehicleData> _vehicleList = [];
    var res = await _db.query('$vehicleTable');
    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        _vehicleList.add(VehicleData(
            id: res[i]["id"],
            vehicleType: res[i]["vehicleType"],
            vehicleNo: res[i]["vehicleNo"],
            driverName: res[i]["driverName"],
            driverContact: res[i]["driverContact"],
            helperName: res[i]["helperName"],
            helperContact: res[i]["helperContact"],
            driverAddress: res[i]["driverAddress"]));
      }
    }
    return _vehicleList;
  }

  static Future<int> update(VehicleData vehicleData) async {
    return await _db.update('$vehicleTable', vehicleData.toMap(),
        where: 'id=?', whereArgs: [vehicleData.id]);
  }

  static Future<int> delete(VehicleData vehicleData) async {
    return await _db
        .delete('$vehicleTable', where: 'id=?', whereArgs: [vehicleData.id]);
  }

  //Supplier
  static Future<int> insertSupplier(SupplierData supplierData) async {
    var table =
        await _db.rawQuery("SELECT MAX(id)+1 as id from $supplierTable");
    int id = table.first['id'];
    var raw = await _db.rawInsert(
        "INSERT INTO $supplierTable(id,supplierName,supplierAddress,supplierContact)"
        "VALUES(?,?,?,?)",
        [
          id,
          supplierData.supplierName,
          supplierData.supplierAddress,
          supplierData.supplierContact
        ]);
    return raw;
  }

  static Future<List<SupplierData>> querySupplier() async {
    List<SupplierData> _supplierList = [];
    var res = await _db.query('$supplierTable');
    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        _supplierList.add(SupplierData(
            id: res[i]["id"],
            supplierName: res[i]["supplierName"],
            supplierAddress: res[i]["supplierAddress"],
            supplierContact: res[i]["supplierContact"]));
      }
    }
    return _supplierList;
  }

  static Future<int> updateSupplier(SupplierData supplierData) async {
    return await _db.update('$supplierTable', supplierData.toMap(),
        where: 'id=?', whereArgs: [supplierData.id]);
  }

  static Future<int> deleteSupplier(SupplierData supplierData) async {
    return await _db
        .delete('$supplierTable', where: 'id=?', whereArgs: [supplierData.id]);
  }

  //Sales
  static Future<int> insertSales(SalesData salesData) async {
    var table = await _db.rawQuery("SELECT MAX(id)+1 as id from $salesTable");
    int id = table.first['id'];
    var raw = await _db.rawInsert(
        "INSERT INTO $salesTable(id,salesDate,materialName,customerName,quantity,remarks,saleAmount)"
        "VALUES(?,?,?,?,?,?,?)",
        [
          id,
          salesData.salesDate,
          salesData.materialName,
          salesData.customerName,
          salesData.quantity,
          salesData.remarks,
          salesData.saleAmount
        ]);
    return raw;
  }

  static Future<List<SalesData>> querySales() async {
    List<SalesData> _salesList = [];
    var res = await _db.query('$salesTable');
    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        _salesList.add(SalesData(
            id: res[i]["id"],
            salesDate: res[i]["salesDate"],
            materialName: res[i]["materialName"],
            customerName: res[i]["customerName"],
            quantity: res[i]["quantity"],
            remarks: res[i]["remarks"],
            saleAmount: res[i]["saleAmount"]));
      }
    }
    return _salesList;
  }

  static Future<int> updateSales(SalesData salesData) async {
    return await _db.update('$salesTable', salesData.toMap(),
        where: 'id=?', whereArgs: [salesData.id]);
  }

  static Future<int> deleteSales(SalesData salesData) async {
    return await _db
        .delete('$salesTable', where: 'id=?', whereArgs: [salesData.id]);
  }

  //bills
  static Future<int> insertBills(BillData billData) async {
    var table = await _db.rawQuery("SELECT MAX(id)+1 as id from $billsTable");
    int id = table.first['id'];
    var raw = await _db.rawInsert(
        "INSERT INTO $billsTable(id,billDate,billNo,customerName,amount,materialName,vehicleNo,allowance)"
        "VALUES(?,?,?,?,?,?,?,?)",
        [
          id,
          billData.billDate,
          billData.billNo,
          billData.customerName,
          billData.amount,
          billData.materialName,
          billData.vehicleNo,
          billData.allowance
        ]);
    return raw;
  }

  static Future<List<BillData>> queryBills() async {
    List<BillData> _billList = [];
    var res = await _db.query('$billsTable');
    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        _billList.add(BillData(
            id: res[i]["id"],
            billDate: res[i]["billDate"],
            billNo: res[i]["billNo"],
            customerName: res[i]["customerName"],
            amount: res[i]["amount"],
            materialName: res[i]["materialName"],
            vehicleNo: res[i]["vehicleNo"],
            allowance: res[i]["allowance"]));
      }
    }
    return _billList;
  }

  static Future<int> updateBills(BillData billData) async {
    return await _db.update('$billsTable', billData.toMap(),
        where: 'id=?', whereArgs: [billData.id]);
  }

  static Future<int> deleteBills(BillData billData) async {
    return await _db
        .delete('$billsTable', where: 'id=?', whereArgs: [billData.id]);
  }

  //Materials
  static Future<int> insertMaterial(MaterialData materialData) async {
    var table =
        await _db.rawQuery("SELECT MAX(id)+1 as id from $materialTable");
    int id = table.first['id'];
    var raw = await _db.rawInsert(
        "INSERT INTO $materialTable(id,materialName,details)"
        "VALUES(?,?,?)",
        [id, materialData.materialName, materialData.details]);
    return raw;
  }

  static Future<List<MaterialData>> queryMaterial() async {
    List<MaterialData> _materialList = [];
    var res = await _db.query('$materialTable');
    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        _materialList.add(MaterialData(
            id: res[i]["id"],
            materialName: res[i]["materialName"],
            details: res[i]["details"]));
      }
    }
    return _materialList;
  }

  static Future<int> updateMaterial(MaterialData materialData) async {
    return await _db.update('$materialTable', materialData.toMap(),
        where: 'id=?', whereArgs: [materialData.id]);
  }

  static Future<int> deleteMaterial(MaterialData materialData) async {
    return await _db
        .delete('$materialTable', where: 'id=?', whereArgs: [materialData.id]);
  }

  //Report
  static Future<int> insertReport(ReportData reportData) async {
    var table = await _db.rawQuery("SELECT MAX(id)+1 as id from $reportTable");
    int id = table.first['id'];
    var raw = await _db.rawInsert(
        "INSERT INTO $reportTable(id,reportNo,reportDate,vehicleNo,materialName,allowance)"
        "VALUES(?,?,?,?,?,?)",
        [
          id,
          reportData.reportNo,
          reportData.reportDate,
          reportData.vehicleNo,
          reportData.materialName,
          reportData.allowance
        ]);
    return raw;
  }

  static Future<List<ReportData>> queryReport() async {
    List<ReportData> _reportList = [];
    var res = await _db.query('$reportTable');
    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        _reportList.add(ReportData(
            id: res[i]["id"],
            reportNo: res[i]["reportNo"],
            reportDate: res[i]["reportDate"],
            vehicleNo: res[i]["vehicleNo"],
            materialName: res[i]["materialName"],
            allowance: res[i]["allowance"]));
      }
    }
    return _reportList;
  }

  static Future<int> updateReport(ReportData reportData) async {
    return await _db.update('$reportTable', reportData.toMap(),
        where: 'id=?', whereArgs: [reportData.id]);
  }

  static Future<int> deleteReport(ReportData reportData) async {
    return await _db
        .delete('$reportTable', where: 'id=?', whereArgs: [reportData.id]);
  }
}
