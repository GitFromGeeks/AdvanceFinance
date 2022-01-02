import 'dart:ffi';

import 'package:af/screens/add_customer.dart';
import 'package:af/screens/customer_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:af/utils/database.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var bCode = [
    'QSR001',
    'QSS002',
    'QSF004',
    'QSS005',
    'QSM006',
    'QSS007',
    'QSS008'
  ];

  checkPeriodHelper(period) {
    if (period == "Today") {
      return DateTime.now();
    }
    if (period == "This Week") {
      return DateTime.now();
    }
  }

  late var initfinanceMode;
  late var initbcode;
  @override
  void initState() {
    super.initState();
    initfinanceMode = "SAMSUNG Finance";
    initbcode = "QSR001";
  }

  var financeModes = [
    'SAMSUNG Finance',
    'Bajaj Finance',
    'HDB Finance',
    'HDFC Finance',
    'Home Credit',
    'Self Finance'
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Advance Finance",
            style: GoogleFonts.abel(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.08)),
          ),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  // Navigator.of(context).pushNamed("/add_customer");
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: Duration(seconds: 1),
                          child: Add_customer(),
                          type: PageTransitionType.rightToLeft));
                },
                child: Row(
                  children: [
                    Text(
                      "Add",
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    )
                  ],
                ))
          ],
          titleSpacing: 15,
          backgroundColor: Colors.black,
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Container(
                color: Colors.white,
                child: DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSelectedItems: true,
                  items: bCode,
                  onChanged: (newValue) {
                    setState(() {
                      // branch_codeController.text = newValue!;
                      initbcode = newValue!;
                    });
                  },
                  selectedItem: "QSR001",
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                color: Colors.white,
                child: DropdownSearch(
                  mode: Mode.MENU,
                  showSelectedItems: true,
                  items: financeModes,
                  onChanged: (newValue) {
                    setState(() {
                      // finance_Controller.text = newValue.toString();
                      initfinanceMode = newValue!.toString();
                    });
                  },
                  selectedItem: "SAMSUNG Finance",
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                color: Colors.white,
                child: DropdownSearch(
                  mode: Mode.MENU,
                  showSelectedItems: true,
                  items: [
                    'Today',
                    'This Week',
                    'This Month',
                    '2 Months',
                    'This Year'
                  ],
                  onChanged: (newValue) {
                    // setState(() {});
                  },
                  selectedItem: "Today",
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: Container(
                  color: Colors.black,
                  child: Flexible(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Database.readDataWithFilter(
                          fMode: initfinanceMode, bCode: initbcode),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        } else if (snapshot.hasData || snapshot.data != null) {
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 2.0),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              String name = snapshot.data!.docs[index]['name'];
                              String imei = snapshot.data!.docs[index]['imei'];
                              DateTime dateTime =
                                  snapshot.data!.docs[index]['date'].toDate();
                              String date =
                                  "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          duration: Duration(milliseconds: 500),
                                          child: Customer_details(imei: imei),
                                          type:
                                              PageTransitionType.rightToLeft));
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             Customer_details(
                                  //               imei: imei,
                                  //             )));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          title: Text(
                                            name,
                                            style: GoogleFonts.abel(
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05)),
                                          ),
                                          trailing: Text(
                                            date,
                                            style: GoogleFonts.abel(
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return Text("Loading");
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
