import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:af/utils/database.dart';

// ignore: camel_case_types
class Customer_details extends StatefulWidget {
  final String imei;
  const Customer_details({
    Key? key,
    required this.imei,
  }) : super(key: key);
  @override
  _Customer_detailsState createState() => _Customer_detailsState();
}

// ignore: camel_case_types
class _Customer_detailsState extends State<Customer_details> {
  // ignore: non_constant_identifier_names
  _EMI_PopUp(context, emiPaid, emi, totalDue, docId) {
    Alert(
        context: context,
        title: "EMI pay",
        content: Text("Are you sure?"),
        buttons: [
          DialogButton(
              child: Text("Pay"),
              onPressed: () {
                Database.updateItem(
                    emiPaid: emiPaid + 1,
                    amountPaid: (emiPaid + 1) * emi,
                    remAmount: totalDue - ((emiPaid + 1) * emi),
                    docId: docId);
                Database.addEmiHistory(emi: emi, cusId: docId);
                Navigator.of(context).pop();
              })
        ]).show();
  }

  // ignore: non_constant_identifier_names
  _deleted_confirm(context, docId) {
    Alert(
        context: context,
        title: "Delete",
        content: Text("Are you sure?"),
        buttons: [
          DialogButton(
              color: Colors.grey,
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          DialogButton(
              child: Text("Yes"),
              onPressed: () {
                Database.deleteItem(docId: docId);
                Navigator.of(context).pushNamed("/home");
              })
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer's Details"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: Database.readOne(uid: widget.imei),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            } else if (snapshot.hasData || snapshot.data != null) {
              return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 1.0),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  String docId = snapshot.data!.docs[index].id;
                  String name = snapshot.data!.docs[index]['name'];
                  String phoneNo = snapshot.data!.docs[index]['phone_no'];
                  String email = snapshot.data!.docs[index]['email'];
                  String address = snapshot.data!.docs[index]['address'];
                  String loanId = snapshot.data!.docs[index]['loan_id'];
                  String model = snapshot.data!.docs[index]['model'];
                  String bcode = snapshot.data!.docs[index]['branch_code'];
                  String imei = snapshot.data!.docs[index]['imei'];
                  double duration = snapshot.data!.docs[index]['duration'];
                  String refName = snapshot.data!.docs[index]['ref_name'];
                  String refNo = snapshot.data!.docs[index]['ref_phone_no'];
                  String adhaarFront =
                      snapshot.data!.docs[index]['adhaar_front'];
                  String adhaarBack = snapshot.data!.docs[index]['adhaar_back'];
                  String panCard = snapshot.data!.docs[index]['pan_photo'];
                  double fileCharge = snapshot.data!.docs[index]['file_charge'];
                  double dp = snapshot.data!.docs[index]['dp'];
                  double price = snapshot.data!.docs[index]['price'];
                  double totalDue = snapshot.data!.docs[index]['total_due'];
                  double emi = snapshot.data!.docs[index]['emi'];
                  double emiPaid = snapshot.data!.docs[index]['emi_paid'];
                  double amountPaid = snapshot.data!.docs[index]['amount_paid'];
                  double remAmount = snapshot.data!.docs[index]['rem_amount'];
                  DateTime dateTime =
                      snapshot.data!.docs[index]['date'].toDate();
                  String date =
                      "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                  DateTime dateTime1 =
                      snapshot.data!.docs[index]['lastDue'].toDate();
                  String lastDue =
                      "${dateTime1.day}-${dateTime1.month}-${dateTime1.year} : ${dateTime1.hour} :${dateTime1.minute} :${dateTime1.second}";
                  String description =
                      snapshot.data!.docs[index]['description'];
                  String profile = snapshot.data!.docs[index]['profile'];
                  String financeMode =
                      snapshot.data!.docs[index]['financeMode'];
                  return Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                  image: NetworkImage(profile)),
                              Expanded(
                                child: Column(
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Name : ",
                                            style: GoogleFonts.abel(),
                                          ),
                                          Text(
                                            name,
                                            style: GoogleFonts.abel(),
                                          ),
                                          SizedBox(
                                            width: 200.0,
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Loan ID : ",
                                          style: GoogleFonts.abel(),
                                        ),
                                        Text(
                                          loanId,
                                          style: GoogleFonts.abel(),
                                        )
                                      ],
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Model : ",
                                            style: GoogleFonts.abel(),
                                          ),
                                          Text(
                                            model,
                                            style: GoogleFonts.abel(),
                                          ),
                                          SizedBox(
                                            width: 200.0,
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "PRICE : ",
                                          style: GoogleFonts.abel(),
                                        ),
                                        Text(
                                          "$price/-",
                                          style: GoogleFonts.abel(),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                "Mobile.No : ",
                                style: GoogleFonts.abel(),
                              ),
                              Text(
                                phoneNo,
                                style: GoogleFonts.abel(),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                "Branch Code : ",
                                style: GoogleFonts.abel(),
                              ),
                              Text(
                                bcode,
                                style: GoogleFonts.abel(),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                "IMEI : ",
                                style: GoogleFonts.abel(),
                              ),
                              Text(
                                imei,
                                style: GoogleFonts.abel(),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                "Down Payment : ",
                                style: GoogleFonts.abel(),
                              ),
                              Text(
                                "${dp.round()}",
                                style: GoogleFonts.abel(),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                "Finance Mode : ",
                                style: GoogleFonts.abel(),
                              ),
                              Text(
                                financeMode,
                                style: GoogleFonts.abel(),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                "File Charge : ",
                                style: GoogleFonts.abel(),
                              ),
                              Text(
                                "${(fileCharge).round()}/-",
                                style: GoogleFonts.abel(),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                "Duration : ",
                                style: GoogleFonts.abel(),
                              ),
                              Text(
                                "${(duration).round()}",
                                style: GoogleFonts.abel(),
                              ),
                              Text(
                                "months",
                                style: GoogleFonts.abel(),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                "Total Due : ",
                                style: GoogleFonts.abel(),
                              ),
                              Text(
                                "${(totalDue).round()}/-",
                                style: GoogleFonts.abel(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                "EMI : ",
                                style: GoogleFonts.abel(),
                              ),
                              Text(
                                "${(emi).round()}/-",
                                style: GoogleFonts.abel(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                "Remaining Balance : ",
                                style: GoogleFonts.abel(),
                              ),
                              Text(
                                "${(remAmount).round()}/-",
                                style: GoogleFonts.abel(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                "EMI Paid : ",
                                style: GoogleFonts.abel(),
                              ),
                              Text(
                                "${(emiPaid).round()}",
                                style: GoogleFonts.abel(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                "Amount Paid : ",
                                style: GoogleFonts.abel(),
                              ),
                              Text(
                                "${(amountPaid).round()}/-",
                                style: GoogleFonts.abel(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                "Ref. Name : ",
                                style: GoogleFonts.abel(),
                              ),
                              Text(
                                refName,
                                style: GoogleFonts.abel(),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                "Ref. Mob. No. : ",
                                style: GoogleFonts.abel(),
                              ),
                              Text(
                                "$refNo",
                                style: GoogleFonts.abel(),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                "Description: ",
                                style: GoogleFonts.abel(),
                              ),
                              Text(
                                description,
                                style: GoogleFonts.abel(),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                "Last-Due : ",
                                style: GoogleFonts.abel(),
                              ),
                              Text(
                                lastDue,
                                style: GoogleFonts.abel(),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                "Date. : ",
                                style: GoogleFonts.abel(),
                              ),
                              Text(
                                date,
                                style: GoogleFonts.abel(),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                "email: ",
                                style: GoogleFonts.abel(),
                              ),
                              Text(
                                email,
                                style: GoogleFonts.abel(),
                              )
                            ],
                          ),
                          FittedBox(
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                Text(
                                  "Add : ",
                                  style: GoogleFonts.abel(),
                                ),
                                Text(
                                  address,
                                  style: GoogleFonts.abel(),
                                ),
                                SizedBox(
                                  width: 150,
                                )
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  height:
                                      MediaQuery.of(context).size.width * 0.1,
                                ),
                                Image(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height:
                                        MediaQuery.of(context).size.width * 0.9,
                                    image: NetworkImage(adhaarFront)),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                ),
                                Image(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height:
                                        MediaQuery.of(context).size.width * 0.9,
                                    image: NetworkImage(adhaarBack)),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                ),
                                Image(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height:
                                        MediaQuery.of(context).size.width * 0.9,
                                    image: NetworkImage(panCard)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          FittedBox(
                            child: Row(
                              children: [
                                CupertinoButton(
                                    borderRadius: BorderRadius.circular(0),
                                    color: Colors.green,
                                    child: Text("Pay EMI"),
                                    onPressed: () {
                                      _EMI_PopUp(context, emiPaid, emi,
                                          totalDue, docId);
                                    }),
                                CupertinoButton(
                                    borderRadius: BorderRadius.circular(0),
                                    color: Colors.red,
                                    child: Text("Delete File"),
                                    onPressed: () {
                                      _deleted_confirm(context, docId);
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: () {},
          label: Icon(
            Icons.download,
          )),
    );
  }
}
