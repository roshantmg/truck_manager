import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:tipper_system/data/curd.dart';
import 'package:tipper_system/models/bills.dart';
import 'package:tipper_system/models/vehicle.dart';
import 'package:tipper_system/widgets/text_widget.dart';

class BillsScreen extends StatefulWidget {
  @override
  _BillsScreenState createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
 // i start from here to get list of number plates
  List<String> numberPlates = [];

  //to get selected vechile id after on click by defaul its unassigned


  int selectedVehicleId;
  String selectedNumberPlate;

  @override
  void initState() {
    initialize();
    super.initState();
  }


  initialize()async{
    numberPlates = await getvehicleNo();
  }


  List<DropdownMenuItem<String>>  generateDropDownItemOfNumberPlates(){
    List<DropdownMenuItem<String>> menuitems = [];

    numberPlates.forEach((String numberPlate) {
      menuitems.add(DropdownMenuItem(
        child: Container(

          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(children: [
            Text(numberPlate , style: TextStyle(color: Colors.black), ),


          ],),
        ),
        value: numberPlate,
      ));


    });

    return menuitems;

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<DataCollection>(
      builder: (context, billData, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Bills Record'),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              splashColor: Colors.green,
              onPressed: () {
                BillData _billData = BillData();
                // VehicleData _vehicleData = VehicleData();

                // DataCollection dc = DataCollection();
                // dc.getVehicleList().then((value) => {
                //       this.vehiclesNumber =
                //           value.map((e) => e.vehicleNo).toList(),
                //       this._vehicle = this.vehiclesNumber[0]
                //     });

                final NepaliDateTime now = NepaliDateTime.now();
                final NepaliDateFormat formatter =
                    NepaliDateFormat('yyyy-MM-dd');
                _billData.billDate = (formatter.format(now).toString());
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
                                      hintValue: 'Bill Number',
                                      keyboard: TextInputType.number,
                                      onChanged: (value) {
                                        _billData.billNo = value;
                                      },
                                    ),
                                    // DropdownButtonFormField(
                                    //   items:
                                    //       vehiclesNumber.map((String category) {
                                    //     return new DropdownMenuItem(
                                    //         value: category,
                                    //         child: Row(
                                    //           children: <Widget>[
                                    //             Icon(Icons.star),
                                    //             Text(category),
                                    //           ],
                                    //         ));
                                    //   }).toList(),

                                    //   onChanged: (newValue) {
                                    //     // do other stuff with _category
                                    //     setState(() => _vehicle = newValue);
                                    //   },
                                    //   value: _vehicle,
                                    //   //  decoration: InputDecoration(
                                    //   //    contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                    //   //      filled: true,
                                    //   //      fillColor: Colors.grey[200],
                                    //   //      hintText: Localization.of(context).category,
                                    //   //      errorText: errorSnapshot.data == 0 ? Localization.of(context).categoryEmpty : null),
                                    // ),
                                     Container(
                                      margin: EdgeInsets.all(25.0),
                                      padding: EdgeInsets.all(2),

                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Theme.of(context).primaryColor, width: 0.8),
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: DropdownButton(
                                        underline: SizedBox(),
                                        style: TextStyle(color: Colors.white),

                                        isExpanded: true,
                                        hint: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                                            child: Text('Select Vechile', style: TextStyle(color: Colors.black, fontSize: 18.0),)),

                                        onChanged: (value)  async {
                                           selectedVehicleId =  await onSelectedVechNumber(selectedNumberPlate);

                                           print(selectedVehicleId);
                                           print(selectedNumberPlate);
                                        },

                                        value: selectedNumberPlate,
                                        items: generateDropDownItemOfNumberPlates(),
                                      ),
                                    ),
                                    CustomTextField(
                                      hintValue: 'Vehicle No',
                                      onChanged: (value) {
                                        _billData.vehicleNo = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Customer Name',
                                      onChanged: (value) {
                                        _billData.customerName = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Material Name',
                                      onChanged: (value) {
                                        _billData.materialName = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Amount',
                                      onChanged: (value) {
                                        _billData.amount = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Allowance',
                                      onChanged: (value) {
                                        _billData.allowance = value;
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
                                                _billData.billDate = (formatter
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
                                            _billData.billDate,
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
                                        billData.insertBillsData(_billData);
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
            body: FutureBuilder<List<BillData>>(
              future: billData.getbillList(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<BillData>> snapshot) {
                if (snapshot.hasData) {
                  List<BillData> billList = snapshot.data;
                  if (billList.length > 0) {
                    return ListView.builder(
                      itemCount: billList.length,
                      itemBuilder: (context, position) {
                        BillData resultbills = billList[position];
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
                                        'TIPPER SYSTEM PVT.LTD',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Bill No: ${resultbills.billNo}',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text('Date : ${resultbills.billDate}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  Divider(),
                                  Text(
                                    'Vehicle No : ${resultbills.vehicleNo}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Customer Name : ${resultbills.customerName}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Divider(),
                                  Text(
                                    'Material Name : ${resultbills.materialName}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'Allowance : ${resultbills.allowance}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'Amount : ${resultbills.amount}',
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
                                          BillData _billData =
                                              billList[position];
                                          final NepaliDateTime now =
                                              NepaliDateTime.now();
                                          final NepaliDateFormat formatter =
                                              NepaliDateFormat('yyyy-MM-dd');
                                          _billData.billDate = (formatter
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
                                                                    _billData
                                                                        .billNo,
                                                                keyboard:
                                                                    TextInputType
                                                                        .number,
                                                                onChanged:
                                                                    (value) {
                                                                  _billData
                                                                          .billNo =
                                                                      value;
                                                                },
                                                              ),
                                                              CustomTextField(
                                                                hintValue:
                                                                    _billData
                                                                        .vehicleNo,
                                                                onChanged:
                                                                    (value) {
                                                                  _billData
                                                                          .vehicleNo =
                                                                      value;
                                                                },
                                                              ),
                                                              CustomTextField(
                                                                hintValue: _billData
                                                                    .customerName,
                                                                onChanged:
                                                                    (value) {
                                                                  _billData
                                                                          .customerName =
                                                                      value;
                                                                },
                                                              ),
                                                              CustomTextField(
                                                                hintValue: _billData
                                                                    .materialName,
                                                                onChanged:
                                                                    (value) {
                                                                  _billData
                                                                          .materialName =
                                                                      value;
                                                                },
                                                              ),
                                                              CustomTextField(
                                                                hintValue:
                                                                    _billData
                                                                        .amount,
                                                                onChanged:
                                                                    (value) {
                                                                  _billData
                                                                          .amount =
                                                                      value;
                                                                },
                                                              ),
                                                              CustomTextField(
                                                                hintValue:
                                                                    _billData
                                                                        .allowance,
                                                                onChanged:
                                                                    (value) {
                                                                  _billData
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
                                                                          _billData.billDate = (formatter
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
                                                                          _billData
                                                                              .billDate,
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
                                                                  billData.updateBillsData(
                                                                      _billData);
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
                                          billData.removeBillsData(
                                              billList[position]);
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
                          'Create Bills',
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
