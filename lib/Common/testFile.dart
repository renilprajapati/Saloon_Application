import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/Common/common_colors.dart';

class TestFile extends StatefulWidget {
  const TestFile({super.key});

  @override
  State<TestFile> createState() => _TestFileState();
}

class _TestFileState extends State<TestFile> {

  List arr = [
    {'id': '1', 'name': 'Cricket'},
    {'id': '2', 'name': 'Kabbadi'},
    {'id': '3', 'name': 'Kho-Kho'},
  ];

  int? indexx;
  bool isChecked = false;
  List checkvalues = [false,false,false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: arr.length,
        itemBuilder: (BuildContext context, int index) {
        return Center(
          child: Container(
            width: Get.width*0.9,
            height: Get.height*0.1,
            color: Colors.grey.withOpacity(0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(arr[index]['name']),
            Checkbox(
              checkColor: Colors.white,
              // fillColor:common_clr,
              value: checkvalues[index],
              onChanged: (bool? value) {
                setState(() {
                  indexx = index;
                  if(indexx == index){
                    checkvalues[index] = value;
                  }
                });
              },
            ),
                checkvalues[index] == true
                    ?
                InkWell(
                    onTap: (){
                      setState(() {
                        arr.removeAt(index);
                        checkvalues.removeAt(index);
                      });
                    },
                    child: const Icon(Icons.delete))
                    :const SizedBox(),
              ],
            ),
          ),
        );
      },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: Get.height*0.03,);
      },
      
      ),
    );
  }
}
