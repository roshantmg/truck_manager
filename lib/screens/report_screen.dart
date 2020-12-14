import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:tipper_system/data/curd.dart';
import 'package:tipper_system/models/report.dart';
import 'package:tipper_system/widgets/text_widget.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataCollection>(
      builder: (context, reportData, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Report'),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              splashColor: Colors.green,
              onPressed: () {
                ReportData _reportData = ReportData();

                final NepaliDateTime now = NepaliDateTime.now();
                final NepaliDateFormat formatter =
                    NepaliDateFormat('yyyy-MM-dd');
                _reportData.reportDate = (formatter.format(now).toString());
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
                                      hintValue: 'Report Number',
                                      keyboard: TextInputType.number,
                                      onChanged: (value) {
                                        _reportData.reportNo = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Vehicle No',
                                      onChanged: (value) {
                                        _reportData.vehicleNo = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Material Name',
                                      onChanged: (value) {
                                        _reportData.materialName = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Allowance',
                                      onChanged: (value) {
                                        _reportData.allowance = value;
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        picker.showCupertinoDatePicker(
                                          context: context,
                                          firstDate: NepaliDateTime(2000),
                                          lastDate: NepaliDateTime(2090),
                                          language: Language.nepali,
                                          dateOrder: picker.DateOrder.ymd,
                                          onDateChanged: (newDate) {
                                            final NepaliDateFormat formatter =
                                                NepaliDateFormat('yyyy-MM-dd');

                                            state(
                                              () {
                                                _reportData.reportDate =
                                                    (formatter
                                                        .format(newDate)
                                                        .toString());
                                              },
                                            );
                                          },
                                          initialDate: NepaliDateTime.now(),
                                        );
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
                                            _reportData.reportDate,
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
                                        reportData
                                            .insertReportData(_reportData);
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
            body: FutureBuilder<List<ReportData>>(
              future: reportData.getReportList(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ReportData>> snapshot) {
                if (snapshot.hasData) {
                  List<ReportData> reportList = snapshot.data;
                  if (reportList.length > 0) {
                    return ListView.builder(
                      itemCount: reportList.length,
                      itemBuilder: (context, position) {
                        ReportData resultreport = reportList[position];
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            color: Colors.yellow[300],
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
                                        'TIPPER SYSTEM PVT.LTD',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Report No: ${resultreport.reportNo}',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text('Date : ${resultreport.reportDate}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  Divider(),
                                  Text(
                                    'Vehicle No : ${resultreport.vehicleNo}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Material Name : ${resultreport.materialName}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'Allowance : ${resultreport.allowance}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          ReportData _reportData =
                                              reportList[position];

                                          final NepaliDateTime now =
                                              NepaliDateTime.now();
                                          final NepaliDateFormat formatter =
                                              NepaliDateFormat('yyyy-MM-dd');
                                          _reportData.reportDate = (formatter
                                              .format(now)
                                              .toString());
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
                                                              200,
                                                          child: ListView(
                                                            children: [
                                                              CustomTextField(
                                                                hintValue:
                                                                    _reportData
                                                                        .reportNo,
                                                                keyboard:
                                                                    TextInputType
                                                                        .number,
                                                                onChanged:
                                                                    (value) {
                                                                  _reportData
                                                                          .reportNo =
                                                                      value;
                                                                },
                                                              ),
                                                              CustomTextField(
                                                                hintValue:
                                                                    _reportData
                                                                        .vehicleNo,
                                                                onChanged:
                                                                    (value) {
                                                                  _reportData
                                                                          .vehicleNo =
                                                                      value;
                                                                },
                                                              ),
                                                              CustomTextField(
                                                                hintValue:
                                                                    _reportData
                                                                        .materialName,
                                                                onChanged:
                                                                    (value) {
                                                                  _reportData
                                                                          .materialName =
                                                                      value;
                                                                },
                                                              ),
                                                              CustomTextField(
                                                                hintValue:
                                                                    _reportData
                                                                        .allowance,
                                                                onChanged:
                                                                    (value) {
                                                                  _reportData
                                                                          .allowance =
                                                                      value;
                                                                },
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  picker
                                                                      .showCupertinoDatePicker(
                                                                    context:
                                                                        context,
                                                                    firstDate:
                                                                        NepaliDateTime(
                                                                            2000),
                                                                    lastDate:
                                                                        NepaliDateTime(
                                                                            2090),
                                                                    language:
                                                                        Language
                                                                            .nepali,
                                                                    dateOrder: picker
                                                                        .DateOrder
                                                                        .dmy,
                                                                    onDateChanged:
                                                                        (newDate) {
                                                                      final NepaliDateFormat
                                                                          formatter =
                                                                          NepaliDateFormat(
                                                                              'yyyy-MM-dd');

                                                                      state(
                                                                        () {
                                                                          _reportData.reportDate = (formatter
                                                                              .format(newDate)
                                                                              .toString());
                                                                        },
                                                                      );
                                                                    },
                                                                    initialDate:
                                                                        NepaliDateTime
                                                                            .now(),
                                                                  );
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
                                                                          _reportData
                                                                              .reportDate,
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
                                                                  reportData
                                                                      .updateReportData(
                                                                          _reportData);
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
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          reportData.removeReportData(
                                              reportList[position]);
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
                          'Create a report',
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
