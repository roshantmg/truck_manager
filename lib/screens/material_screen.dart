import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tipper_system/data/curd.dart';
import 'package:tipper_system/models/material.dart';
import 'package:tipper_system/widgets/text_widget.dart';

class MaterialScreen extends StatefulWidget {
  @override
  _MaterialScreenState createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<DataCollection>(builder: (context, materialdata, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Material Record'),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            splashColor: Colors.red,
            onPressed: () {
              MaterialData _materialdata = MaterialData();
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
                                hintValue: 'Material Name',
                                onChanged: (value) {
                                  _materialdata.materialName = value;
                                },
                              ),
                              CustomTextField(
                                hintValue: 'Details',
                                onChanged: (value) {
                                  _materialdata.details = value;
                                },
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).viewInsets.bottom ==
                                            0
                                        ? 10
                                        : 200,
                              ),
                              GestureDetector(
                                onTap: () {
                                  materialdata
                                      .insertMaterialData(_materialdata);
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
        body: FutureBuilder<List<MaterialData>>(
          future: materialdata.getMaterialList(),
          builder: (BuildContext context,
              AsyncSnapshot<List<MaterialData>> snapshot) {
            if (snapshot.hasData) {
              List<MaterialData> materialList = snapshot.data;
              if (materialList.length > 0) {
                return ListView.builder(
                    itemCount: materialList.length,
                    itemBuilder: (context, position) {
                      MaterialData resultMaterial = materialList[position];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 0.0),
                        child: Card(
                          color: Colors.deepOrange[300],
                          elevation: 5.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' Material Name : ${resultMaterial.materialName}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 16.0),
                              ),
                              Text(
                                '  Details : ${resultMaterial.details}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        MaterialData _materialdata =
                                            materialList[position];
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
                                                              _materialdata
                                                                  .materialName,
                                                          onChanged: (value) {
                                                            _materialdata
                                                                    .materialName =
                                                                value;
                                                          },
                                                        ),
                                                        CustomTextField(
                                                          hintValue:
                                                              _materialdata
                                                                  .details,
                                                          onChanged: (value) {
                                                            _materialdata
                                                                    .details =
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
                                                              : 200,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            materialdata
                                                                .updateMaterialData(
                                                                    _materialdata);
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
                                        materialdata.removeMaterialData(
                                            materialList[position]);
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
                    'Add the material details.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                );
              }
            } else {
              return Container(
                child: Center(
                    child: Text(
                  'Add the material details.',
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
