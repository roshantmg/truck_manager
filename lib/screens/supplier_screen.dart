import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tipper_system/data/curd.dart';
import 'package:tipper_system/models/supplier.dart';
import 'package:tipper_system/widgets/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SupplierScreen extends StatefulWidget {
  @override
  _SupplierScreenState createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataCollection>(builder: (context, supplierdata, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Supplier Record'),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            splashColor: Colors.pink,
            onPressed: () {
              SupplierData _supplierdata = SupplierData();
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height - 100,
                          child: ListView(
                            children: [
                              CustomTextField(
                                hintValue: 'Supplier Name',
                                onChanged: (value) {
                                  _supplierdata.supplierName = value;
                                },
                              ),
                              CustomTextField(
                                hintValue: 'Supplier Address',
                                onChanged: (value) {
                                  _supplierdata.supplierAddress = value;
                                },
                              ),
                              CustomTextField(
                                hintValue: 'Supplier Contact',
                                keyboard: TextInputType.number,
                                onChanged: (value) {
                                  _supplierdata.supplierContact = value;
                                },
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).viewInsets.bottom ==
                                            0
                                        ? 10
                                        : 300,
                              ),
                              GestureDetector(
                                onTap: () {
                                  supplierdata
                                      .insertSupplierData(_supplierdata);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  padding: EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                        width: 0.8, color: Colors.black38),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Save',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
                  });
            }),
        body: FutureBuilder<List<SupplierData>>(
          future: supplierdata.getSupplierList(),
          builder: (BuildContext context,
              AsyncSnapshot<List<SupplierData>> snapshot) {
            if (snapshot.hasData) {
              List<SupplierData> supplierList = snapshot.data;
              if (supplierList.length > 0) {
                return ListView.builder(
                    itemCount: supplierList.length,
                    itemBuilder: (context, position) {
                      SupplierData resultSupplier = supplierList[position];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Card(
                          color: Colors.pink[20],
                          elevation: 5.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Supplier Name : ${resultSupplier.supplierName}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 16.0),
                              ),
                              Text(
                                'Supplier Address : ${resultSupplier.supplierAddress}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.contact_phone,
                                              color: Colors.greenAccent),
                                          onPressed: () {
                                            launch(
                                                'tel://${resultSupplier.supplierContact}');
                                          }),
                                      Text(
                                        'Supplier Contact : ${resultSupplier.supplierContact}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            SupplierData _supplierdata =
                                                supplierList[position];
                                            showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return StatefulBuilder(
                                                      builder:
                                                          (context, state) {
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
                                                            100,
                                                        child: ListView(
                                                          children: [
                                                            CustomTextField(
                                                              hintValue:
                                                                  _supplierdata
                                                                      .supplierName,
                                                              onChanged:
                                                                  (value) {
                                                                _supplierdata
                                                                        .supplierName =
                                                                    value;
                                                              },
                                                            ),
                                                            CustomTextField(
                                                              hintValue:
                                                                  _supplierdata
                                                                      .supplierAddress,
                                                              onChanged:
                                                                  (value) {
                                                                _supplierdata
                                                                        .supplierAddress =
                                                                    value;
                                                              },
                                                            ),
                                                            CustomTextField(
                                                              hintValue:
                                                                  _supplierdata
                                                                      .supplierContact,
                                                              keyboard:
                                                                  TextInputType
                                                                      .number,
                                                              onChanged:
                                                                  (value) {
                                                                _supplierdata
                                                                        .supplierContact =
                                                                    value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                              context)
                                                                          .viewInsets
                                                                          .bottom ==
                                                                      0
                                                                  ? 10
                                                                  : 300,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                supplierdata
                                                                    .updateSupplierData(
                                                                        _supplierdata);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
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
                                                                      BorderRadius
                                                                          .circular(
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
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                                });
                                          }),
                                      IconButton(
                                          icon: Icon(Icons.delete),
                                          color: Colors.red[400],
                                          onPressed: () {
                                            supplierdata.removeSupplierData(
                                                supplierList[position]);
                                          }),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Container(
                  child: Center(
                      child: Text(
                    'Add the supplier details.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                );
              }
            } else {
              return Container(
                child: Center(
                    child: Text(
                  'Add the supplier details.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              );
            }
          },
        ),
      );
    });
  }
}
