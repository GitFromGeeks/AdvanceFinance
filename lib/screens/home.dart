import 'package:af/screens/customer_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:af/utils/database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.05,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/login");
                          },
                          child: Row(
                            children: [
                              Text(
                                "LOGOUT",
                                style: GoogleFonts.abel(),
                              ),
                              Icon(Icons.logout)
                            ],
                          )),
                    ],
                  ),
                ],
              ),
              Image(
                  width: MediaQuery.of(context).size.width * 0.5,
                  image: AssetImage("af.png")),
              Divider(thickness: 2.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Customers",
                    style: GoogleFonts.abel(
                        textStyle: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.08)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black)),
                      onPressed: () {
                        Navigator.of(context).pushNamed("/add_customer");
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
              ),
              Divider(thickness: 2.0),
              Card(
                child: Row(
                  children: [
                    // Flexible(
                    //   child: TextField(
                    //     decoration: InputDecoration(
                    //         hintText: "     Search by Name/Date"),
                    //   ),
                    // ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text("Month"),
                            Icon(Icons.arrow_drop_down)
                          ],
                        )),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text("Branch"),
                            Icon(Icons.arrow_drop_down)
                          ],
                        )),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text("Finance"),
                            Icon(Icons.arrow_drop_down)
                          ],
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.black,
                  child: Flexible(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Database.readItem(),
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
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Customer_details(
                                                imei: imei,
                                              )));
                                },
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          title: Text(date),
                                          trailing: Text(name),
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
