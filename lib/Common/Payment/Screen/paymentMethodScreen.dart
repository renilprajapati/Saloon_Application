import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:saloon_app/BottomBar/BookingHistory/Screen/BookingHistoryScreen.dart';
import 'package:saloon_app/Common/common_colors.dart';

class paymentMethodScreen extends StatefulWidget {
  double? subtotal;
  String? SaloonName;
  String? appoinmentId;
  paymentMethodScreen(
      {required this.subtotal,
      required this.SaloonName,
      required this.appoinmentId});

  @override
  State<paymentMethodScreen> createState() => _paymentMethodScreenState();
}

class _paymentMethodScreenState extends State<paymentMethodScreen> {
  Color golden = const Color(0xFFC18F2C);
  Color green = const Color(0xFF1F4B3E);
  var _razorpay = Razorpay();
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
    print("payment Method Screen appointMent Id :${widget.appoinmentId}");
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("Payment Done");
    Get.snackbar('Payment ', 'Payment successfully done');

    Get.to(BookingHistoryScreen(
      route: "paymentMethodScreen",
      appoinmentId: widget.appoinmentId,
    ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment Fail");
    Get.snackbar('Payment Failed', 'Payment Failed some rezone');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: common_clr,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
            )),
        title: Text(
          "Payment",
          style: GoogleFonts.mulish(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        actions: [],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    var options = {
                      'key': "rzp_test_806FBZNWquQ8AL",
                      // amount will be multiple of 100
                      'amount':
                          (widget.subtotal! * 100).toString(), //So its pay 500
                      'name': '${widget.SaloonName}',
                      'description': 'Demo',
                      'timeout': 300, // in seconds
                      'prefill': {
                        'contact': '6354822734',
                        'email': 'parshwpa@gmail.com'
                      }
                    };
                    _razorpay.open(options);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.93,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: golden),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Radio(
                          value: 1,
                          groupValue: "1",
                          onChanged: (value) {
                            print("$value");
                          },
                        ),
                        Container(
                          child: Icon(
                            Icons.wallet,
                            color: green,
                          ),
                        ),
                        Text(
                          "RazorPay",
                          style: TextStyle(
                              color: green,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Container(
                          width: 130,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }
}
