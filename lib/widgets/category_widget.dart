import 'package:flutter/material.dart';
import 'package:tipper_system/screens/bill_screen.dart';
import 'package:tipper_system/screens/material_screen.dart';
import 'package:tipper_system/screens/report_screen.dart';
import 'package:tipper_system/screens/sales_screen.dart';
import 'package:tipper_system/screens/supplier_screen.dart';
import 'package:tipper_system/screens/vehicle_screen.dart';
import 'package:tipper_system/widgets/icons.dart';

class CategoryWidget extends StatefulWidget {
  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  Widget categorylist(
    String categoryname,
    final Color colors,
    final IconData icons,
    final Widget widget,
  ) {
    return Card(
      // margin: EdgeInsets.all(14.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return widget;
            }),
          );
        },
        splashColor: Colors.blue,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icons,
                color: colors,
                size: 50.0,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                categoryname,
                style: new TextStyle(
                    fontSize: 12.0, fontWeight: FontWeight.bold, color: colors),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.2,
        width: MediaQuery.of(context).size.width,
        child: GridView.count(
          padding: EdgeInsets.all(5.0),
          crossAxisCount: 3,
          children: [
            categorylist('BILLS', Colors.black, MyIcons.bills, BillsScreen()),
            categorylist(
                'VEHICLE', Colors.black, Icons.local_shipping, VehicleScreen()),
            categorylist(
                'SUPPLIER', Colors.black, MyIcons.supplier, SupplierScreen()),
            categorylist('MATERIAL', Colors.black, MyIcons.repair_tools,
                MaterialScreen()),
            categorylist(
                'SALES', Colors.black, MyIcons.profitloss, SalesScreen()),
            categorylist(
                'REPORT', Colors.black, MyIcons.report_no1, ReportScreen()),
          ],
        ),
      ),
    );
  }
}
