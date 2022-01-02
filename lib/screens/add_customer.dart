import 'dart:io';
import 'dart:math';
import 'package:af/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:af/utils/database.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class Add_customer extends StatefulWidget {
  @override
  _Add_customerState createState() => _Add_customerState();
}

// ignore: camel_case_types
class _Add_customerState extends State<Add_customer> {
  // ignore: non_constant_identifier_names
  _submit_Popup(context) async {
    Alert(
        context: context,
        title: "Added",
        content: Text(
          "Successfully!",
          style: TextStyle(fontSize: 10.0),
        ),
        buttons: [
          DialogButton(
              child: Text("ok"),
              onPressed: () {
                print("adding User to Firestore --------------");
                Database.add_customer_Model(
                  name: nameController.text,
                  phone_no: phone_noController.text,
                  email: emailController.text,
                  address: addressController.text,
                  loan_id: load_idController.text,
                  model: modelController.text,
                  imei: imeiController.text,
                  ref_name: ref_nameController.text,
                  ref_phone_no: ref_phone_noController.text,
                  profile: _uploadedprofile!,
                  adhaar_front: _uploadedadhaarFront!,
                  adhaar_back: _uploadedadhaarBack!,
                  pan_photo: _uploadedpan_photo!,
                  file_charge: double.parse(file_chargeController.text),
                  dp: double.parse(dpController.text),
                  price: double.parse(priceController.text),
                  duration: double.parse(durationController.text),
                  description: descController.text,
                  financeMode: finance_Controller.text,
                  branch_code: branch_codeController.text,
                );
                // Navigator.pop(context);
                // Navigator.of(context).pushNamed("/home");
                Navigator.push(
                    context,
                    PageTransition(
                        child: Home(), type: PageTransitionType.leftToRight));
              })
        ]).show();
  }

  final TextEditingController nameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController phone_noController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController load_idController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController imeiController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController ref_nameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController ref_phone_noController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController file_chargeController = TextEditingController();
  final TextEditingController dpController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController total_dueController = TextEditingController();
  final TextEditingController emiController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController emi_paidController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController amount_paidController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController rem_amountController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  final TextEditingController finance_Controller = TextEditingController();
  final TextEditingController branch_codeController = TextEditingController();

  // void clearText() {
  //   nameController.clear();
  //   phone_noController.clear();
  //   emailController.clear();
  //   addressController.clear();
  //   load_idController.clear();
  //   modelController.clear();
  //   branch_codeController.clear();
  //   imeiController.clear();
  //   ref_nameController.clear();
  //   ref_phone_noController.clear();
  //   file_chargeController.clear();
  //   dpController.clear();
  //   priceController.clear();
  //   durationController.clear();
  //   total_dueController.clear();
  //   emiController.clear();
  //   emi_paidController.clear();
  //   amount_paidController.clear();
  //   rem_amountController.clear();
  // }

  // List
  var bCode = [
    'QSR001',
    'QSS002',
    'QSF004',
    'QSS005',
    'QSM006',
    'QSS007',
    'QSS008'
  ];
  var financeModes = [
    'SAMSUNG Finance',
    'Bajaj Finance',
    'HDB Finance',
    'HDFC Finance',
    'Home Credit',
    'Self Finance'
  ];

  final ImagePicker _picker = ImagePicker();

  File? profileImage;
  File? adhaarFront;
  File? adhaarBack;
  // ignore: non_constant_identifier_names
  File? pan_photo;

  String? _uploadedprofile;
  String? _uploadedadhaarFront;
  String? _uploadedadhaarBack;
  // ignore: non_constant_identifier_names
  String? _uploadedpan_photo;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    profileImage = null;
    adhaarFront = null;
    adhaarBack = null;
    pan_photo = null;
    _uploadedprofile = null;
    _uploadedadhaarFront = null;
    _uploadedadhaarBack = null;
    _uploadedpan_photo = null;
  }

  _picProfile() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (image != null) {
      setState(() {
        profileImage = File(image.path);
      });
    }
  }

  _picAdhaarFront() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (image != null) {
      setState(() {
        adhaarFront = File(image.path);
      });
    }
  }

  _picAdhaarBack() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (image != null) {
      setState(() {
        adhaarBack = File(image.path);
      });
    }
  }

  _picPanPhoto() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (image != null) {
      setState(() {
        pan_photo = File(image.path);
      });
    }
  }

  Random random = Random();

  //initialize storage
  FirebaseStorage _storage = FirebaseStorage.instance;

// for Profile photo
  _uploadProfileToStorageHelper(File image) async {
    int randomNumber1 = random.nextInt(10);
    int randomNumber2 = randomNumber1 * 10 + random.nextInt(20);
    int randomNumber3 = random.nextInt(30);
    int number = randomNumber1 + randomNumber2 + randomNumber3;
    Reference ref = _storage.ref().child(
        "Documents/customer_photo/profile${DateTime.now().microsecond}$number");
    UploadTask uploadTask = ref.putFile(image);
    String imgUrl = await (await uploadTask).ref.getDownloadURL();
    setState(() {
      _uploadedprofile = imgUrl;
    });
  }

//for adhaar front
  _uploadAdhaarFrontToStorageHelper(File image) async {
    int randomNumber1 = random.nextInt(10);
    int randomNumber2 = randomNumber1 * 10 + random.nextInt(20);
    int randomNumber3 = random.nextInt(30);
    Reference ref = _storage.ref().child(
        "Documents/Adhaar_Card/Front_Side/adhaar${DateTime.now().microsecond}$randomNumber1$randomNumber2$randomNumber3");
    UploadTask uploadTask = ref.putFile(image);
    String imgUrl = await (await uploadTask).ref.getDownloadURL();
    setState(() {
      _uploadedadhaarFront = imgUrl;
    });
  }

  _uploadAdhaarBackToStorageHelper(File image) async {
    int randomNumber1 = random.nextInt(10);
    int randomNumber2 = randomNumber1 * 10 + random.nextInt(20);
    int randomNumber3 = random.nextInt(30);
    Reference ref = _storage.ref().child(
        "Documents/Adhaar_Card/Back_Side/adhaar${DateTime.now().microsecond}$randomNumber1$randomNumber2$randomNumber3");
    UploadTask uploadTask = ref.putFile(image);
    String imgUrl = await (await uploadTask).ref.getDownloadURL();
    setState(() {
      _uploadedadhaarBack = imgUrl;
    });
  }

  _uploadPanCardToStorageHelper(File image) async {
    Reference ref = _storage
        .ref()
        .child("Documents/Pan_Card/pan${DateTime.now().microsecond}");
    UploadTask uploadTask = ref.putFile(image);
    String imgUrl = await (await uploadTask).ref.getDownloadURL();
    setState(() {
      _uploadedpan_photo = imgUrl;
      isLoading = false;
    });
    _submit_Popup(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "New File",
          style: GoogleFonts.abel(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.08)),
        ),
      ),
      body: isLoading
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [CircularProgressIndicator(), Text("Please wait")],
            ))
          : Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Form(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Image(
                            width: MediaQuery.of(context).size.width * 0.35,
                            image: AssetImage("af.png")),
                        TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.black,
                            icon: Icon(
                              Icons.account_circle_rounded,
                              color: Colors.black,
                            ),
                            labelText: "Name",
                          ),
                          controller: nameController,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.phone,
                                color: Colors.black,
                              ),
                              labelText: "Mobile Number"),
                          controller: phone_noController,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              labelText: "email"),
                          controller: emailController,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.local_activity_sharp,
                                color: Colors.black,
                              ),
                              labelText: "Address"),
                          controller: addressController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.input_rounded,
                                color: Colors.black,
                              ),
                              labelText: "Loan ID"),
                          controller: load_idController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.phone_android,
                                color: Colors.black,
                              ),
                              labelText: "Model"),
                          controller: modelController,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.price_change,
                                color: Colors.black,
                              ),
                              labelText: "Price"),
                          controller: priceController,
                        ),
                        // TextFormField(
                        //   decoration: InputDecoration(
                        //       icon: Icon(Icons.input_rounded),
                        //       labelText: "Branch Code"),
                        //   controller: branch_codeController,
                        // ),
                        // TextFormField(
                        //   decoration: InputDecoration(
                        //       icon: Icon(Icons.input_rounded),
                        //       labelText: "Finance"),
                        //   controller: finance_Controller,
                        // ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.input_rounded,
                                color: Colors.black,
                              ),
                              labelText: "IMEI"),
                          controller: imeiController,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.input_rounded,
                                color: Colors.black,
                              ),
                              labelText: "Down payment"),
                          controller: dpController,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.input_rounded,
                                color: Colors.black,
                              ),
                              labelText: "File Charge"),
                          controller: file_chargeController,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.timelapse,
                                color: Colors.black,
                              ),
                              labelText: "Duration"),
                          controller: durationController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.description,
                                color: Colors.black,
                              ),
                              labelText: "Ref. Name"),
                          controller: ref_nameController,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.description,
                                color: Colors.black,
                              ),
                              labelText: "Ref. No."),
                          controller: ref_phone_noController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.description,
                                color: Colors.black,
                              ),
                              labelText: "Description"),
                          controller: descController,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        // DropdownButton(
                        //     hint: Text(
                        //   "Branch Code : ${branch_codeController.text}",
                        //   style: TextStyle(fontSize: 20),
                        //   ),
                        //   value: selectedBCode,
                        //   icon: Icon(Icons.arrow_drop_down),
                        //   iconSize: 42,
                        //   underline: SizedBox(),
                        //   onChanged: (),
                        //   ),
                        DropdownSearch<String>(
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          items: bCode,
                          onChanged: (newValue) {
                            print("---------------------");
                            setState(() {
                              print(newValue);
                              branch_codeController.text = newValue!;
                            });
                          },
                          label: "Branch Code",
                          selectedItem: " ",
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        DropdownSearch(
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          items: financeModes,
                          onChanged: (newValue) {
                            print("----------------");
                            setState(() {
                              print(newValue);
                              finance_Controller.text = newValue.toString();
                            });
                          },
                          label: "Finance Mode",
                          selectedItem: " ",
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.05),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black),
                                onPressed: () {
                                  _picProfile();
                                },
                                child: Text("Browse")),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.05),
                            Text("Customer's Photo"),
                            SizedBox(width: 10),
                            profileImage != null
                                ? Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  )
                                : Text("")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.05),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black),
                                onPressed: () {
                                  _picAdhaarFront();
                                },
                                child: Text("Browse")),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.05),
                            Text("Adhaar Front"),
                            SizedBox(width: 10),
                            adhaarFront != null
                                ? Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  )
                                : Text("")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.05),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black),
                                onPressed: () {
                                  _picAdhaarBack();
                                },
                                child: Text("Browse")),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.05),
                            Text("Adhaar Back"),
                            SizedBox(width: 10),
                            adhaarBack != null
                                ? Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  )
                                : Text("")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.05),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black),
                                onPressed: () {
                                  _picPanPhoto();
                                },
                                child: Text("Browse")),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.05),
                            Text("Pan Card"),
                            SizedBox(width: 10),
                            pan_photo != null
                                ? Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  )
                                : Text("")
                          ],
                        ),
                        CupertinoButton(
                            borderRadius:
                                BorderRadius.all(Radius.circular(18.0)),
                            color: Colors.black,
                            child: Text(
                              "Submit",
                              style: GoogleFonts.abel(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.06)),
                            ),
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                              });
                              print(
                                  "Uploading Profile photo---------------------");
                              _uploadProfileToStorageHelper(profileImage!);
                              print("Uploading adhaar front --------------");
                              _uploadAdhaarFrontToStorageHelper(adhaarFront!);
                              print("Uploading Adhar Back -------------");
                              _uploadAdhaarBackToStorageHelper(adhaarBack!);
                              print(
                                  "Uploading pan card-----------------------");
                              _uploadPanCardToStorageHelper(pan_photo!);
                            })
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
