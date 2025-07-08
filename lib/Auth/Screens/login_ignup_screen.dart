import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saloon_app/Auth/Controller/LoginController.dart';
import 'package:saloon_app/Auth/Controller/RegisterController.dart';
import 'package:saloon_app/Common/Textstyles/Textstyles.dart';
import 'package:saloon_app/Common/common_colors.dart';
import 'package:saloon_app/BottomBar/Home/Screen/HomePage.dart';

class loginSignupScreen extends StatefulWidget {
  const loginSignupScreen({super.key});

  @override
  State<loginSignupScreen> createState() => _loginSignupScreenState();
}

class _loginSignupScreenState extends State<loginSignupScreen> {
  var index = 0;
  int value = 1;

  final RegisterController _registerCont_obj = Get.put(RegisterController());
  final LoginController _loginCont_obj = Get.put(LoginController());

  var selectedGender;

  @override
  void initState() {
    index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            width: Get.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: Colors.blue,
                  width: Get.width,
                  child: Column(
                    children: [
                      Container(
                        height: Get.height * 0.38,
                        width: Get.width,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/Rectangle-1.png"),
                                fit: BoxFit.fill)),
                      ),
                      Container(
                        height:
                            value == 1 ? Get.height * 0.5 : Get.height * 0.9,
                        width: Get.width,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: Get.height * 0.27,
                  child: Container(
                    height: value == 1 ? Get.height * 0.29 : Get.height * 0.95,
                    width: Get.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(
                                0.5), // Adjust shadow color and opacity
                            offset: const Offset(4, 4), // Adjust shadow offset
                            blurRadius: 8, // Adjust shadow blur radius
                            spreadRadius: 2, // Adjust shadow spread
                          )
                        ]),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        value = 1;
                                      });
                                    },
                                    child: Text(
                                      "SignIn",
                                      style: value == 1
                                          ? FontStyles.w400_24_black
                                          : const TextStyle(),
                                    )),
                                value == 1
                                    ? Container(
                                        width: Get.width * 0.18,
                                        height: Get.height * 0.004,
                                        color: common_clr,
                                      )
                                    : Container()
                              ],
                            ),
                            Column(
                              children: [
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        value = 2;
                                      });
                                    },
                                    child: Text("SignUp",
                                        style: value == 2
                                            ? FontStyles.w400_24_black
                                            : const TextStyle())),
                                value == 2
                                    ? Container(
                                        width: Get.width * 0.18,
                                        height: Get.height * 0.004,
                                        color: common_clr,
                                      )
                                    : Container()
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),

                        ///=====================SIGNING CONTAINER===============///
                        value == 1
                            ? SizedBox(
                                width: Get.width * 0.9,
                                height: Get.height * 0.15,
                                // color: Colors.red,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.03,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.8,
                                      height: Get.height * 0.06,
                                      // color: Colors.red,
                                      child: TextFormField(
                                        controller:
                                            _loginCont_obj.mobileNumberTEC,
                                        decoration: InputDecoration(
                                          hintText: "Mobile Number",
                                          hintStyle: FontStyles.w300_15_black,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.03,
                                    ),
                                  ],
                                ),
                              )
                            :

                            ///========================SIGNUP CONTAINER===========================///
                            SizedBox(
                                width: Get.width * 0.9,
                                // height: Get.height*0.3,
                                child: Column(
                                  children: [
                                    ///=======================FIRST NAME FIELD=======================///
                                    SizedBox(
                                      height: Get.height * 0.03,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.8,
                                      height: Get.height * 0.06,
                                      // color: Colors.red,
                                      child: TextFormField(
                                        controller:
                                            _registerCont_obj.firstNameCTC,
                                        decoration: InputDecoration(
                                          hintText: "First Name",
                                          hintStyle: FontStyles.w300_15_black,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                        ),
                                      ),
                                    ),

                                    ///=======================LAST NAME FIELD=======================///
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.8,
                                      height: Get.height * 0.06,
                                      // color: Colors.red,
                                      child: TextFormField(
                                        controller:
                                            _registerCont_obj.lastNameCTC,
                                        decoration: InputDecoration(
                                          hintText: "Last Name",
                                          hintStyle: FontStyles.w300_15_black,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                        ),
                                      ),
                                    ),

                                    ///=======================MOBILE NUMBER FIELD=======================///
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.8,
                                      height: Get.height * 0.06,
                                      // color: Colors.red,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller:
                                            _registerCont_obj.mobileNumberCTC,
                                        decoration: InputDecoration(
                                          hintText: "Mobile Number",
                                          hintStyle: FontStyles.w300_15_black,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                        ),
                                      ),
                                    ),

                                    ///=======================EMAIL FIELD=======================///
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.8,
                                      height: Get.height * 0.06,
                                      // color: Colors.red,
                                      child: TextFormField(
                                        controller: _registerCont_obj.emailCTC,
                                        decoration: InputDecoration(
                                          hintText: "Email",
                                          hintStyle: FontStyles.w300_15_black,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                        ),
                                      ),
                                    ),

                                    ///=======================GENDER FIELD=======================///
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.8,
                                      // height: Get.height*0.06,
                                      child: DropdownButtonFormField(
                                        decoration: InputDecoration(
                                          hintText: "Select Gender",
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                        ),
                                        value: selectedGender,
                                        onChanged: (value) {
                                          selectedGender = value;
                                          _registerCont_obj.genderCTC.text =
                                              selectedGender;
                                        },
                                        items: ['Male', 'Female'].map((gender) {
                                          return DropdownMenuItem(
                                            value: gender,
                                            child: Text(gender),
                                          );
                                        }).toList(),
                                      ),
                                    ),

                                    ///=======================BIRTHDATE FIELD=======================///
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.8,
                                      height: Get.height * 0.06,
                                      // color: Colors.red,
                                      child: TextFormField(
                                        onTap: () {
                                          _selectDate();
                                        },
                                        readOnly: true,
                                        controller:
                                            _registerCont_obj.birthDateCTC,
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.calendar_month_outlined,
                                            color: Colors.black,
                                          ),
                                          hintText: "Birth Date",
                                          hintStyle: FontStyles.w300_15_black,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                        ),
                                      ),
                                    ),

                                    ///=======================PINCODE FIELD=======================///
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.8,
                                      height: Get.height * 0.06,
                                      // color: Colors.red,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller:
                                            _registerCont_obj.pincodeCTC,
                                        decoration: InputDecoration(
                                          hintText: "Pincode",
                                          hintStyle: FontStyles.w300_15_black,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                        ),
                                      ),
                                    ),

                                    ///=======================ADDRESS FIELD=======================///
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.8,
                                      height: Get.height * 0.065,
                                      // color: Colors.red,
                                      child: TextFormField(
                                        controller:
                                            _registerCont_obj.addressCTC,
                                        decoration: InputDecoration(
                                          hintText: "Address",
                                          hintStyle: FontStyles.w300_15_black,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: common_clr)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: value == 1 ? Get.height * 0.5 : Get.height * 1.15,
                  child: InkWell(
                    onTap: () {
                      if (value == 1) {
                        _loginCont_obj
                            .loginCont(_loginCont_obj.mobileNumberTEC.text);
                        print("login");
                      } else {
                        print("Signup");
                        _registerCont_obj.registerCont(
                          _registerCont_obj.firstNameCTC.text,
                          _registerCont_obj.lastNameCTC.text,
                          _registerCont_obj.mobileNumberCTC.text,
                          _registerCont_obj.emailCTC.text,
                          _registerCont_obj.genderCTC.text,
                          _registerCont_obj.birthDateCTC.text,
                          _registerCont_obj.pincodeCTC.text,
                          _registerCont_obj.addressCTC.text,
                        );
                      }
                    },
                    child: Obx(() {
                      return Container(
                        width: Get.width * 0.27,
                        height: Get.height * 0.12,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(
                                    0.5), // Adjust shadow color and opacity
                                offset:
                                    const Offset(0, 10), // Adjust shadow offset
                                blurRadius: 8, // Adjust shadow blur radius
                                spreadRadius: 2, // Adjust shadow spread
                              )
                            ]),
                        child: Center(
                          child: Container(
                            width: Get.width * 0.2,
                            height: Get.height * 0.2,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: common_clr),
                            child: _registerCont_obj.loading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : _loginCont_obj.loading.value
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.arrow_right_alt,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                          ),
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        String selectedDate = DateFormat('yyyy/MM/dd').format(picked);
        _registerCont_obj.birthDateCTC.text = selectedDate.toString();
      });
    }
  }
}
