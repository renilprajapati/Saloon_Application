import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:saloon_app/Common/Textstyles/Textstyles.dart';
import 'package:saloon_app/Common/common_appbar.dart';
import 'package:saloon_app/Common/common_colors.dart';

class AddReviewsScreen extends StatefulWidget {
  const AddReviewsScreen({super.key});

  @override
  State<AddReviewsScreen> createState() => _AddReviewsScreenState();
}

class _AddReviewsScreenState extends State<AddReviewsScreen> {
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
              Text(
                "Reviews",
                style: FontStyles.w400_20_white,
              ))),
      body: Center(
        child: SizedBox(
          width: Get.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),
              Image.asset(
                "assets/images/Rectangle 66.png",
                width: Get.width * 0.95,
              ),
              Text(
                "Christopher Hair & Beauty",
                style: FontStyles.bold_20_commonColor,
              ),
              Text(
                "Hair Saloon",
                style: FontStyles.w300_15_black,
              ),

              ///=============SHOW RATINGS===============///
              Row(
                children: [
                  RatingBarIndicator(
                    rating: 2.75,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Text(
                    "4.0",
                    style: FontStyles.w300_15_black,
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Text(
                    "(225 ratings)",
                    style: FontStyles.w300_15_black,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Your Overall rating of this Service",
                        style: FontStyles.w700_15_grey,
                      ),

                      ///====================ADD RATINGS==================///
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      )
                    ],
                  )
                ],
              ),
              Text(
                "Add Detailed Review",
                style: FontStyles.w400_24_black,
              ),
              SizedBox(
                width: Get.width * 0.9,
                // height: Get.height*0.06,
                child: TextFormField(
                  // minLines: 0,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Add Review....",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: common_clr)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              // Get.to(()=> const BookingHistoryScreen());
            },
            child: Container(
              alignment: Alignment.center,
              width: Get.width * 0.9,
              height: Get.height * 0.06,
              decoration: BoxDecoration(
                  // color: Colors.red,
                  border: Border.all(color: common_clr),
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                "Done",
                style: FontStyles.bold_20_commonColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
