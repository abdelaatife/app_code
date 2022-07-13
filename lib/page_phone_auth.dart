// ignore_for_file: prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api, unnecessary_this, use_build_context_synchronously

import 'package:app/page_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: constant_identifier_names
enum PhoneVerificationState {
  SHOW_PHONE_FORM_STATE,
  SHOW_OTP_FORM_STATE
}

class PhoneAuthPage extends StatefulWidget {
  @override
  _PhoneAuthPageState createState() =>
      _PhoneAuthPageState();
}

class _PhoneAuthPageState
    extends State<PhoneAuthPage> {
  final GlobalKey<ScaffoldState>
      _scaffoldKeyForSnackBar = GlobalKey();
  PhoneVerificationState currentState =
      PhoneVerificationState
          .SHOW_PHONE_FORM_STATE;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  late String verificationIDFromFirebase;
  bool spinnerLoading = false;
  var _fullname, _age, _phone;
  GlobalKey<FormState> formstate =
      new GlobalKey<FormState>();
  FirebaseFirestore firestore =
      FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth =
      FirebaseAuth.instance;
//verifyPhoneNumber is a method that will be called when the user clicks on the button.
  _verifyPhoneButton() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      setState(() {
        spinnerLoading = true;
      });
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneController.text,
          verificationCompleted:
              (phoneAuthCredential) async {
            setState(() {
              spinnerLoading = false;
            });

            //signInWithPhoneAuthCredential(phoneAuthCredential);
          },
          //verificationFailed method will be called when the verification fails.
          verificationFailed:
              (verificationFailed) async {
            setState(() {
              spinnerLoading = true;
            });
          },
          // code sent to the user.
          codeSent: (verificationId,
              resendingToken) async {
            setState(() {
              spinnerLoading = false;
              currentState =
                  PhoneVerificationState
                      .SHOW_OTP_FORM_STATE;
              this.verificationIDFromFirebase =
                  verificationId;
            });
          },
          // timeout.
          codeAutoRetrievalTimeout:
              (verificationId) async {});
    }
  }

// verifyOtp is a method that will check the otp entered by the user.
  _verifyOTPButton() async {
    PhoneAuthCredential phoneAuthCredential =
        PhoneAuthProvider.credential(
            verificationId:
                verificationIDFromFirebase,
            smsCode: otpController.text);
    signInWithPhoneAuthCredential(
        phoneAuthCredential);
  }

// signInWithPhoneAuthCredential method
  void signInWithPhoneAuthCredential(
      PhoneAuthCredential
          phoneAuthCredential) async {
    setState(() {
      spinnerLoading = true;
    });
    try {
      final authCredential = await _firebaseAuth
          .signInWithCredential(
              phoneAuthCredential);
      setState(() {
        spinnerLoading = false;
      });
      if (authCredential.user != null) {
        // Call the user's CollectionReference to add a new user
        CollectionReference users =
            FirebaseFirestore.instance
                .collection('users');

        await users
            .doc(_firebaseAuth.currentUser?.uid)
            .set({
          'full_name': _fullname,
          'age': _age,
          'phone': _phone,
        }).catchError((error) => print(
                "Failed to add user: $error"));

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        spinnerLoading = false;
      });
    }
  }

//phone number form widget.
  getPhoneFormWidget(context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          opacity: 0.05,
          image: AssetImage(
              'assets/xiaomi-Mijia-Sports-Cardiogram-t-shirt-ecg-tricko-5-removebg-preview.png'),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Form(
              key: formstate,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  //full name text field.
                  const Text(
                    "Full Name",
                    style:
                        TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  TextFormField(
                    onSaved: (val) {
                      _fullname = val;
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "please add your full name";
                      }
                      return null;
                    },
                    keyboardType:
                        TextInputType.text,

                    //inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                        hintText:
                            'Enter your full name',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(
                                    Radius.circular(
                                        10.0))),
                        prefixIcon:
                            Icon(Icons.person)),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  //end of full name text field.

                  //age text field.
                  const Text(
                    "Age",
                    style:
                        TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  TextFormField(
                    onSaved: (val) {
                      _age = val;
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "please add your age";
                      }
                      return null;
                    },
                    keyboardType:
                        TextInputType.number,

                    //inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                        hintText: "Age",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(
                                    Radius.circular(
                                        10.0))),
                        prefixIcon: Icon(Icons
                            .calendar_today)),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  //end of age text field.
                  //phone number text field.
                  const Text(
                    "Phone Number",
                    style:
                        TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  TextFormField(
                    onSaved: (val) {
                      _phone = val;
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "please add your phone number";
                      }
                      return null;
                    },
                    keyboardType:
                        TextInputType.phone,
                    maxLength: 13,
                    //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: phoneController,
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                        hintText: "Phone number",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(
                                    Radius.circular(
                                        10.0))),
                        prefixIcon: Icon(Icons
                            .phone_android_rounded)),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  //end of phone number text field.
                ],
              )),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Container(
                width: 320,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(12.0),
                  color: const Color.fromARGB(
                      255, 19, 131, 223),
                ),
                child: MaterialButton(
                  onPressed: () =>
                      _verifyPhoneButton(),
                  // ignore: sort_child_properties_last
                  child: const Text(
                    "Create Account",
                    style:
                        TextStyle(fontSize: 16),
                  ),

                  textColor: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

//otp form widget.
  getOTPFormWidget(context) {
    return Column(
      children: [
        const Text(
          "Enter OTP Number",
          style: TextStyle(fontSize: 16.0),
        ),
        const SizedBox(
          height: 50.0,
        ),
        TextField(
          controller: otpController,
          textAlign: TextAlign.start,
          
          decoration: const InputDecoration(
             border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(
                                    Radius.circular(
                                        10.0))),
              hintText: "OTP Number",
              prefixIcon: Icon(Icons
                  .confirmation_number_rounded)),
        ),
        const SizedBox(
          height: 40.0,
        ),
        Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Container(
                width: 320,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(12.0),
                  color: const Color.fromARGB(
                      255, 19, 131, 223),
                ),
                child: MaterialButton(
                   onPressed: () => _verifyOTPButton(),
                  // ignore: sort_child_properties_last
                  child: const Text(
                    "Verify OTP Number",
                    style:
                        TextStyle(fontSize: 16),
                  ),

                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        
      ],
    );
  }
//add user to firestore

  //end of add user to firestore

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKeyForSnackBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(70.0)),
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/Navy and Red Minimalist Cross EEG Heart Hospital Logo (2).png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: const [
                  Text(
                    "Create Account",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 32.0,
                        fontWeight:
                            FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              spinnerLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator(),
                    )
                  : currentState ==
                          PhoneVerificationState
                              .SHOW_PHONE_FORM_STATE
                      ? getPhoneFormWidget(
                          context)
                      : getOTPFormWidget(context),
            ],
          ),
        ),
      ),
    ));
  }
}
