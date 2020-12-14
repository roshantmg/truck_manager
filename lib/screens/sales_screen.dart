import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:tipper_system/data/curd.dart';
import 'package:tipper_system/models/sales.dart';
import 'package:tipper_system/widgets/text_widget.dart';

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataCollection>(
      builder: (context, saleData, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Sales Record'),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              splashColor: Colors.green,
              onPressed: () {
                SalesData _salesData = SalesData();

                final DateTime now = DateTime.now();
                final DateFormat formatter = DateFormat('yyyy-MM-dd');
                _salesData.salesDate = (formatter.format(now).toString());
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height - 200,
                                child: ListView(
                                  children: [
                                    CustomTextField(
                                      hintValue: 'Material Name',
                                      onChanged: (value) {
                                        _salesData.materialName = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Customer Name',
                                      onChanged: (value) {
                                        _salesData.customerName = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Quantity',
                                      onChanged: (value) {
                                        _salesData.quantity = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Sale Amount',
                                      keyboard: TextInputType.number,
                                      onChanged: (value) {
                                        _salesData.saleAmount =
                                            int.parse(value);
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Remarks',
                                      onChanged: (value) {
                                        _salesData.remarks = value;
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime(1999, 3, 5),
                                            maxTime: DateTime.now(),
                                            onChanged: (date) {
                                          final DateFormat formatter =
                                              DateFormat('yyyy-MM-dd');

                                          state(() {
                                            _salesData.salesDate = (formatter
                                                .format(date)
                                                .toString());
                                          });
                                        }, onConfirm: (date) {
                                          final DateFormat formatter =
                                              DateFormat('yyyy-MM-dd');
                                          state(() {
                                            _salesData.salesDate = (formatter
                                                .format(date)
                                                .toString());
                                          });
                                        },
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.en);
                                      },
                                      child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          padding: EdgeInsets.all(20.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20.0),
                                            ),
                                            border: Border.all(
                                                width: 0.8,
                                                color: Colors.black38),
                                          ),
                                          child: Text(
                                            _salesData.salesDate,
                                            textAlign: TextAlign.center,
                                          )),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom ==
                                              0
                                          ? 10
                                          : 300,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        saleData.insertSalesData(_salesData);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 20.0),
                                        padding: EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          border: Border.all(
                                              width: 0.8,
                                              color: Colors.black38),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Save',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                  ],
                                )),
                          );
                        },
                      );
                    });
              },
            ),
            body: FutureBuilder<List<SalesData>>(
              future: saleData.getsalesList(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<SalesData>> snapshot) {
                if (snapshot.hasData) {
                  List<SalesData> salesList = snapshot.data;
                  if (salesList.length > 0) {
                    return ListView.builder(
                      itemCount: salesList.length,
                      itemBuilder: (context, position) {
                        SalesData resultSales = salesList[position];
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            color: Colors.blueAccent[100],
                            elevation: 10.0,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Material Name : ${resultSales.materialName}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Customer Name : ${resultSales.customerName}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ]),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Quantity : ${resultSales.quantity}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                          'Sale Amount : ${resultSales.saleAmount}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Date : ${resultSales.salesDate}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  Text('Remarks : ${resultSales.remarks}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          SalesData _salesdata =
                                              salesList[position];

                                          showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (BuildContext context) {
                                                return StatefulBuilder(
                                                  builder: (context, state) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                new FocusNode());
                                                      },
                                                      child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height -
                                                              400,
                                                          child: ListView(
                                                            children: [
                                                              CustomTextField(
                                                                hintValue:
                                                                    _salesdata
                                                                        .materialName,
                                                                onChanged:
                                                                    (value) {
                                                                  _salesdata
                                                                          .materialName =
                                                                      value;
                                                                },
                                                              ),
                                                              CustomTextField(
                                                                hintValue:
                                                                    _salesdata
                                                                        .customerName,
                                                                onChanged:
                                                                    (value) {
                                                                  _salesdata
                                                                          .customerName =
                                                                      value;
                                                                },
                                                              ),
                                                              CustomTextField(
                                                                hintValue: (_salesdata
                                                                        .quantity)
                                                                    .toString(),
                                                                onChanged:
                                                                    (value) {
                                                                  _salesdata
                                                                          .quantity =
                                                                      value;
                                                                },
                                                              ),
                                                              CustomTextField(
                                                                hintValue: (_salesdata
                                                                        .saleAmount)
                                                                    .toString(),
                                                                keyboard:
                                                                    TextInputType
                                                                        .number,
                                                                onChanged:
                                                                    (value) {
                                                                  _salesdata
                                                                          .saleAmount =
                                                                      int.parse(
                                                                          value);
                                                                },
                                                              ),
                                                              CustomTextField(
                                                                hintValue:
                                                                    _salesdata
                                                                        .remarks,
                                                                onChanged:
                                                                    (value) {
                                                                  _salesdata
                                                                          .remarks =
                                                                      value;
                                                                },
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  DatePicker.showDatePicker(
                                                                      context,
                                                                      showTitleActions:
                                                                          true,
                                                                      minTime:
                                                                          DateTime(
                                                                              1999,
                                                                              3,
                                                                              5),
                                                                      maxTime:
                                                                          DateTime
                                                                              .now(),
                                                                      onChanged:
                                                                          (date) {
                                                                    final DateFormat
                                                                        formatter =
                                                                        DateFormat(
                                                                            'yyyy-MM-dd');

                                                                    state(() {
                                                                      _salesdata.salesDate = (formatter
                                                                          .format(
                                                                              date)
                                                                          .toString());
                                                                    });
                                                                  }, onConfirm:
                                                                          (date) {
                                                                    final DateFormat
                                                                        formatter =
                                                                        DateFormat(
                                                                            'yyyy-MM-dd');
                                                                    state(() {
                                                                      _salesdata.salesDate = (formatter
                                                                          .format(
                                                                              date)
                                                                          .toString());
                                                                    });
                                                                  },
                                                                      currentTime:
                                                                          DateTime
                                                                              .now(),
                                                                      locale:
                                                                          LocaleType
                                                                              .en);
                                                                },
                                                                child:
                                                                    Container(
                                                                        margin: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10.0),
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                20.0),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          borderRadius:
                                                                              BorderRadius.all(
                                                                            Radius.circular(20.0),
                                                                          ),
                                                                          border: Border.all(
                                                                              width: 0.8,
                                                                              color: Colors.black38),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          _salesdata
                                                                              .salesDate,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        )),
                                                              ),
                                                              SizedBox(
                                                                height: MediaQuery.of(context)
                                                                            .viewInsets
                                                                            .bottom ==
                                                                        0
                                                                    ? 10
                                                                    : 300,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  saleData.updateSalesData(
                                                                      _salesdata);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          10.0,
                                                                      horizontal:
                                                                          20.0),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              20.0),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .blue,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.0),
                                                                    border: Border.all(
                                                                        width:
                                                                            0.8,
                                                                        color: Colors
                                                                            .black38),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      'Update',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                    );
                                                  },
                                                );
                                              });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          saleData.removeSalesData(
                                              salesList[position]);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                        //
                      },
                    );
                  } else {
                    return Container(
                      child: Center(
                        child: Text(
                          'Add your Sales',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }
                } else {
                  return Container(
                    child: Text('ADD DATA'),
                  );
                }
              },
            ));
      },
    );
  }
}
