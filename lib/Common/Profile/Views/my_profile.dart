import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/Common/Profile/Controller/EditProfileProfileController.dart';
import 'package:saloon_app/Common/Textstyles/Textstyles.dart';
import 'package:saloon_app/Common/common_appbar.dart';
import 'package:saloon_app/Common/common_colors.dart';

import '../Controller/GetProfileController.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final EditProfileProfileController _editProfileProfileCont_obj =
      Get.put(EditProfileProfileController());
  final GetProfileController _getProfileCont_obj =
      Get.put(GetProfileController());

  bool _isReadOnly = true;
  bool _isEnable = false;

  @override
  void initState() {
    _getProfileCont_obj.getProfileCont();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height * 0.08),
          child: CommonAppbar(
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              null,
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    _isEnable == false && _isReadOnly
                        ? "Profile"
                        : "Edit Profile",
                    style: FontStyles.w400_20_white,
                  )))),
      body: Obx(() {
        return _getProfileCont_obj.loading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: common_clr,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.03,
                    ),

                    _isEnable == false && _isReadOnly
                        ? Center(
                            child: CachedNetworkImage(
                              imageUrl: _getProfileCont_obj.getProfileImage
                                  .toString()
                                  .replaceAll('[', '')
                                  .replaceAll(']', ''),
                              // imageUrl: "https://res.cloudinary.com/dtwqzd4sz/image/upload/v1706524546/dglbnfwykn4sk587bvor.png",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: Get.width * 0.3,
                                height: Get.height * 0.14,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                  ),
                                ),
                              ),
                              placeholder: (context, url) {
                                return Container(
                                  width: Get.width * 0.3,
                                  height: Get.height * 0.14,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: common_clr),
                                  ),
                                  child: CircularProgressIndicator(
                                    color: common_clr,
                                  ),
                                );
                                return CircularProgressIndicator(
                                  color: common_clr,
                                );
                              },
                              errorWidget: (context, url, error) => Container(
                                width: Get.width * 0.3,
                                height: Get.height * 0.14,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: common_clr),
                                ),
                                child: const Icon(Icons.error_outline),
                              ),
                            ),
                          )
                        : Stack(
                            children: [
                              Center(
                                child: Container(
                                  width: Get.width * 0.3,
                                  height: Get.height * 0.14,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: common_clr),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: pickImage != null
                                              ? FileImage(pickImage!)
                                              : _getProfileCont_obj
                                                          .getProfileImage
                                                          .toString() ==
                                                      ''
                                                  ? AssetImage(
                                                      'assets/images/Address-pana 1.png')
                                                  : NetworkImage(
                                                          '${_getProfileCont_obj.getProfileImage.toString()}')
                                                      as ImageProvider)),
                                ),
                              ),
                              Positioned(
                                  left: Get.width * 0.56,
                                  top: Get.height * 0.1,
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectProfile();
                                        });
                                      },
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 25,
                                        color: common_clr,
                                      )))
                            ],
                          ),

                    ///========================FIRST NAME FIELD=========================///
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    SizedBox(
                      height: Get.height * 0.070,
                      width: Get.width * 0.9,
                      child: TextFormField(
                        controller: _editProfileProfileCont_obj.firstName,
                        readOnly: _isReadOnly,
                        enabled: _isEnable,
                        decoration: InputDecoration(
                            hintText: "First Name",
                            hintStyle: FontStyles.w400_15_black,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: common_clr))),
                      ),
                    ),

                    ///========================LAST NAME FIELD=========================///
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    SizedBox(
                      height: Get.height * 0.070,
                      width: Get.width * 0.9,
                      child: TextFormField(
                        controller: _editProfileProfileCont_obj.lastName,
                        readOnly: _isReadOnly,
                        enabled: _isEnable,
                        decoration: InputDecoration(
                            hintText: "Last Name",
                            hintStyle: FontStyles.w400_15_black,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: common_clr))),
                      ),
                    ),

                    ///========================PHONE NUMBER FIELD=========================///
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    SizedBox(
                      height: Get.height * 0.070,
                      width: Get.width * 0.9,
                      child: TextFormField(
                        controller: _editProfileProfileCont_obj.mobileNumber,
                        readOnly: _isReadOnly,
                        enabled: _isEnable,
                        decoration: InputDecoration(
                            hintText: "Phone Number",
                            hintStyle: FontStyles.w400_15_black,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: common_clr))),
                      ),
                    ),

                    ///========================EMAIL FIELD=========================///
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    SizedBox(
                      height: Get.height * 0.070,
                      width: Get.width * 0.9,
                      child: TextFormField(
                        controller: _editProfileProfileCont_obj.email,
                        readOnly: _isReadOnly,
                        enabled: _isEnable,
                        decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: FontStyles.w400_15_black,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: common_clr))),
                      ),
                    ),

                    ///========================GENDER=========================///
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    // SizedBox(
                    //   height: Get.height*0.06,
                    //   width: Get.width*0.9,
                    //   child: TextFormField(
                    //     readOnly: _isReadOnly,
                    //     enabled: _isEnable,
                    //     decoration: InputDecoration(
                    //         hintText: "Gender",
                    //         hintStyle: FontStyles.w400_15_black,
                    //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: common_clr))
                    //     ),
                    //   ),
                    // ),

                    _isEnable == false
                        ? Container(
                            height: Get.height * 0.075,
                            width: Get.width * 0.9,
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                hintText:
                                    "${_editProfileProfileCont_obj.gender}",
                                hintStyle: TextStyle(
                                    color: _isEnable == false
                                        ? Colors.grey.withOpacity(0.7)
                                        : Colors.black),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: _isEnable == false
                                            ? Colors.grey.withOpacity(0.2)
                                            : Colors.black)),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: _isEnable == false
                                            ? Colors.grey.withOpacity(0.2)
                                            : Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: _isEnable == false
                                            ? Colors.grey.withOpacity(0.2)
                                            : Colors.black)),
                              ),
                              value: _editProfileProfileCont_obj.gender,
                              onChanged: (value) {
                                _editProfileProfileCont_obj.gender =
                                    value.toString();
                                if (kDebugMode) {
                                  print(
                                      'gender : ${_editProfileProfileCont_obj.gender}');
                                }
                              },
                              items: []
                                  .map((gender) => DropdownMenuItem(
                                        value: gender,
                                        child: Text(gender),
                                      ))
                                  .toList(),
                            ),
                          )
                        : Container(
                            height: Get.height * 0.075,
                            width: Get.width * 0.9,
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                hintText:
                                    "${_editProfileProfileCont_obj.gender}",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                              ),
                              value: _editProfileProfileCont_obj.gender,
                              onChanged: (value) {
                                _editProfileProfileCont_obj.gender =
                                    value.toString();
                                if (kDebugMode) {
                                  print(
                                      'gender : ${_editProfileProfileCont_obj.gender}');
                                }
                              },
                              items: ['Male', 'Female']
                                  .map((gender) => DropdownMenuItem(
                                        value: gender,
                                        child: Text(gender),
                                      ))
                                  .toList(),
                            ),
                          ),

                    ///========================DATE OF BIRTH(DOB)=========================///
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    SizedBox(
                      height: Get.height * 0.070,
                      width: Get.width * 0.9,
                      child: TextFormField(
                        controller: _editProfileProfileCont_obj.birthDate,
                        readOnly: _isReadOnly,
                        enabled: _isEnable,
                        decoration: InputDecoration(
                            hintText: "Brith date",
                            hintStyle: FontStyles.w400_15_black,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: common_clr))),
                      ),
                    ),

                    ///========================PINCODE=========================///
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    SizedBox(
                      height: Get.height * 0.070,
                      width: Get.width * 0.9,
                      child: TextFormField(
                        controller: _editProfileProfileCont_obj.pinCode,
                        readOnly: _isReadOnly,
                        enabled: _isEnable,
                        decoration: InputDecoration(
                            hintText: "Pin code",
                            hintStyle: FontStyles.w400_15_black,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: common_clr))),
                      ),
                    ),

                    ///========================ADDRESS=========================///
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    SizedBox(
                      height: Get.height * 0.070,
                      width: Get.width * 0.9,
                      child: TextFormField(
                        controller: _editProfileProfileCont_obj.address,
                        readOnly: _isReadOnly,
                        enabled: _isEnable,
                        decoration: InputDecoration(
                            hintText: "Address",
                            hintStyle: FontStyles.w400_15_black,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: common_clr))),
                      ),
                    ),

                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (_isEnable == false && _isReadOnly) {
                            _isEnable = true;
                            _isReadOnly = false;
                            print("edit Profile open");
                          } else {
                            print("save profile");

                            _editProfileProfileCont_obj
                                .editProfileProfileCont(
                                    _editProfileProfileCont_obj.firstName.text,
                                    _editProfileProfileCont_obj.lastName.text,
                                    _editProfileProfileCont_obj
                                        .mobileNumber.text,
                                    _editProfileProfileCont_obj.email.text,
                                    _editProfileProfileCont_obj.gender
                                        .toString(),
                                    _editProfileProfileCont_obj.birthDate.text,
                                    _editProfileProfileCont_obj.pinCode.text,
                                    _editProfileProfileCont_obj.address.text,
                                    File(pickImage!.path))
                                .then((value) {
                              setState(() {
                                _getProfileCont_obj.getProfileCont();
                                _isEnable = false;
                                _isReadOnly = true;
                              });
                            });
                          }
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: Get.width * 0.9,
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(
                          color: common_clr,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: _editProfileProfileCont_obj.loading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                _isEnable == false && _isReadOnly
                                    ? "Edit Profile"
                                    : "Save",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                      ),
                    )
                  ],
                ),
              );
      }),
    );
  }

  File? pickImage;

  Future<void> selectProfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        pickImage = File(file.path.toString());
      });

      print('pickImage ;$pickImage');
      //
      // print(file.name);
      // print(file.bytes);
      // print(file.size);
      // print(file.extension);
      // print(file.path);
    } else {
      // User canceled the picker
    }
  }
}
