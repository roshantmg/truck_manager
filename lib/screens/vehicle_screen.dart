import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tipper_system/data/curd.dart';
import 'package:tipper_system/models/vehicle.dart';
import 'package:tipper_system/widgets/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class VehicleScreen extends StatefulWidget {
  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataCollection>(builder: (context, vehicledata, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Vehicle Record'),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            splashColor: Colors.green,
            onPressed: () {
              VehicleData _vehicledata = VehicleData();
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
                                hintValue: 'Vehicle Type',
                                onChanged: (value) {
                                  _vehicledata.vehicleType = value;
                                },
                              ),
                              CustomTextField(
                                hintValue: 'Vehicle Number',
                                onChanged: (value) {
                                  _vehicledata.vehicleNo = value;
                                },
                              ),
                              CustomTextField(
                                hintValue: 'Driver Name',
                                onChanged: (value) {
                                  _vehicledata.driverName = value;
                                },
                              ),
                              CustomTextField(
                                hintValue: 'Driver Address',
                                onChanged: (value) {
                                  _vehicledata.driverAddress = value;
                                },
                              ),
                              CustomTextField(
                                hintValue: 'Driver Contact',
                                keyboard: TextInputType.number,
                                onChanged: (value) {
                                  _vehicledata.driverContact = value;
                                },
                              ),
                              CustomTextField(
                                hintValue: 'Helper Name',
                                onChanged: (value) {
                                  _vehicledata.helperName = value;
                                },
                              ),
                              CustomTextField(
                                hintValue: 'Helper Contact',
                                keyboard: TextInputType.number,
                                onChanged: (value) {
                                  _vehicledata.helperContact = value;
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
                                  vehicledata.insertVehicleData(_vehicledata);
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
        body: FutureBuilder<List<VehicleData>>(
          future: vehicledata.getVehicleList(),
          builder: (BuildContext context,
              AsyncSnapshot<List<VehicleData>> snapshot) {
            if (snapshot.hasData) {
              List<VehicleData> vehicleList = snapshot.data;
              if (vehicleList.length > 0) {
                return ListView.builder(
                    itemCount: vehicleList.length,
                    itemBuilder: (context, position) {
                      VehicleData resultVehicle = vehicleList[position];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Card(
                          color: Colors.blueAccent[100],
                          elevation: 5.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Vehicle Type : ${resultVehicle.vehicleType}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 16.0),
                              ),
                              Text(
                                'Vehicle Number : ${resultVehicle.vehicleNo}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0),
                              ),
                              Text(
                                'Driver Name : ${resultVehicle.driverName}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0),
                              ),
                              Text(
                                'Helper Name : ${resultVehicle.helperName}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0),
                              ),
                              Text(
                                'Driver Address : ${resultVehicle.driverAddress}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.contact_phone,
                                              color: Colors.greenAccent),
                                          onPressed: () {
                                            launch(
                                                'tel://${resultVehicle.driverContact}');
                                          }),
                                      Text(
                                        'Driver Contact : ${resultVehicle.driverContact}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.contact_phone,
                                              color: Colors.greenAccent),
                                          onPressed: () {
                                            launch(
                                                'tel://${resultVehicle.helperContact}');
                                          }),
                                      Text(
                                        'helper Contact : ${resultVehicle.helperContact}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        VehicleData _vehicledata =
                                            vehicleList[position];
                                        showModalBottomSheet(
                                            context: context,
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
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height -
                                                            100,
                                                    child: ListView(
                                                      children: [
                                                        CustomTextField(
                                                          hintValue:
                                                              _vehicledata
                                                                  .vehicleType,
                                                          onChanged: (value) {
                                                            _vehicledata
                                                                    .vehicleType =
                                                                value;
                                                          },
                                                        ),
                                                        CustomTextField(
                                                          hintValue:
                                                              _vehicledata
                                                                  .vehicleNo,
                                                          onChanged: (value) {
                                                            _vehicledata
                                                                    .vehicleNo =
                                                                value;
                                                          },
                                                        ),
                                                        CustomTextField(
                                                          hintValue:
                                                              _vehicledata
                                                                  .driverName,
                                                          onChanged: (value) {
                                                            _vehicledata
                                                                    .driverName =
                                                                value;
                                                          },
                                                        ),
                                                        CustomTextField(
                                                          hintValue: _vehicledata
                                                              .driverAddress,
                                                          onChanged: (value) {
                                                            _vehicledata
                                                                    .driverAddress =
                                                                value;
                                                          },
                                                        ),
                                                        CustomTextField(
                                                          hintValue: _vehicledata
                                                              .driverContact,
                                                          keyboard:
                                                              TextInputType
                                                                  .number,
                                                          onChanged: (value) {
                                                            _vehicledata
                                                                    .driverContact =
                                                                value;
                                                          },
                                                        ),
                                                        CustomTextField(
                                                          hintValue:
                                                              _vehicledata
                                                                  .helperName,
                                                          onChanged: (value) {
                                                            _vehicledata
                                                                    .helperName =
                                                                value;
                                                          },
                                                        ),
                                                        CustomTextField(
                                                          hintValue: _vehicledata
                                                              .helperContact,
                                                          keyboard:
                                                              TextInputType
                                                                  .number,
                                                          onChanged: (value) {
                                                            _vehicledata
                                                                    .helperContact =
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
                                                              : 400,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            vehicledata
                                                                .updateVehicleData(
                                                                    _vehicledata);
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
                                                                EdgeInsets.all(
                                                                    20.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.blue,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                              border: Border.all(
                                                                  width: 0.8,
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
                                        vehicledata.removeVehicleData(
                                            vehicleList[position]);
                                      }),
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
                    'Add the details.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                );
              }
            } else {
              return Container(
                child: Center(
                    child: Text(
                  'Add the details.',
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
