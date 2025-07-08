import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/Common/Textstyles/Textstyles.dart';
import 'package:saloon_app/Common/common_appbar.dart';
import 'package:saloon_app/Common/common_colors.dart';
import 'package:saloon_app/BottomBar/Home/Screen/HomePage.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _passwordObsecure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height * 0.08),
          child: CommonAppbar(
              const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              null,
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    "Change Password",
                    style: FontStyles.w400_20_white,
                  )))),
      body: Center(
        child: Column(
          children: [
            ///========================OLD PASSWORD FIELD=========================///
            SizedBox(
              height: Get.height * 0.03,
            ),
            SizedBox(
              width: Get.width * 0.9,
              height: Get.height * 0.06,
              child: TextFormField(
                obscureText: _passwordObsecure,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {
                          if (_passwordObsecure) {
                            setState(() {
                              _passwordObsecure = false;
                            });
                          } else {
                            setState(() {
                              _passwordObsecure = true;
                            });
                          }
                        },
                        child: Icon(_passwordObsecure
                            ? CupertinoIcons.eye
                            : CupertinoIcons.eye_slash)),
                    hintText: "Old Password",
                    hintStyle: FontStyles.w400_15_black,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: common_clr))),
              ),
            ),

            ///========================NEW PASSWORD FIELD=========================///
            SizedBox(
              height: Get.height * 0.03,
            ),
            SizedBox(
              width: Get.width * 0.9,
              height: Get.height * 0.06,
              child: TextFormField(
                obscureText: _passwordObsecure,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {
                          if (_passwordObsecure) {
                            setState(() {
                              _passwordObsecure = false;
                            });
                          } else {
                            setState(() {
                              _passwordObsecure = true;
                            });
                          }
                        },
                        child: Icon(_passwordObsecure
                            ? CupertinoIcons.eye
                            : CupertinoIcons.eye_slash)),
                    hintText: "New Password",
                    hintStyle: FontStyles.w400_15_black,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: common_clr))),
              ),
            ),

            ///========================CONFIRM PASSWORD FIELD=========================///
            SizedBox(
              height: Get.height * 0.03,
            ),
            SizedBox(
              width: Get.width * 0.9,
              height: Get.height * 0.06,
              child: TextFormField(
                obscureText: _passwordObsecure,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {
                          if (_passwordObsecure) {
                            setState(() {
                              _passwordObsecure = false;
                            });
                          } else {
                            setState(() {
                              _passwordObsecure = true;
                            });
                          }
                        },
                        child: Icon(_passwordObsecure
                            ? CupertinoIcons.eye
                            : CupertinoIcons.eye_slash)),
                    hintText: "Confirm Password",
                    hintStyle: FontStyles.w400_15_black,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: common_clr))),
              ),
            ),

            const Spacer(),
            InkWell(
              onTap: () {
                Get.to(() => const HomePage());
              },
              child: Container(
                alignment: Alignment.center,
                width: Get.width * 0.9,
                height: Get.height * 0.06,
                decoration: BoxDecoration(
                  color: common_clr,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
