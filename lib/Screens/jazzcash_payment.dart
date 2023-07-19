import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:feedonations/Constant/snackbar.dart';
import 'package:feedonations/Provider/paymentProvider.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jazzcash_flutter/jazzcash_flutter.dart';
import 'package:provider/provider.dart';


// class JazzCash extends StatefulWidget {
//   JazzCash({Key, key, }) : super(key: key);
//
//   @override
//   _JazzCashState createState() => _JazzCashState();
// }
//
// class _JazzCashState extends State<JazzCash> {
//
//   var responcePrice;
//   bool isLoading = false;
//   payment() async{
//     setState(() {
//       isLoading = true;
//     });
//
//     String dateandtime = DateFormat("yyyyMMddHHmmss").format(DateTime.now());
//     String dexpiredate = DateFormat("yyyyMMddHHmmss").format(DateTime.now().add(const Duration(days: 1)));
//     String tre = "T"+dateandtime;
//     String pp_Amount="500";  // price set
//     String pp_BillReference="billRef";
//     String pp_Description="Description for transaction";
//     String pp_Language="EN";
//     String pp_MerchantID="MC58526";
//     String pp_Password="3h9w49dx3e";
//
//     String pp_ReturnURL="https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction";
//     String pp_ver = "1.1";
//     String pp_TxnCurrency= "PKR";
//     String pp_TxnDateTime=dateandtime.toString();
//     String pp_TxnExpiryDateTime=dexpiredate.toString();
//     String pp_TxnRefNo=tre.toString();
//     String pp_TxnType="CARD";
//     String ppmpf_1="4456733833993";
//     String IntegeritySalt = "wesxzw32c5";
//     String and = '&';
//     String superdata=
//         IntegeritySalt+and+
//             pp_Amount+and+
//             pp_BillReference +and+
//             pp_Description +and+
//             pp_Language +and+
//             pp_MerchantID +and+
//             pp_Password +and+
//             pp_ReturnURL +and+
//             pp_TxnCurrency+and+
//             pp_TxnDateTime +and+
//             pp_TxnExpiryDateTime +and+
//             pp_TxnRefNo+and+
//             pp_TxnType+and+
//             pp_ver+and+
//             ppmpf_1
//     ;
//
//
//
//     var key = utf8.encode(IntegeritySalt);
//     var bytes = utf8.encode(superdata);
//     var hmacSha256 = Hmac(sha256, key);
//     Digest sha256Result = hmacSha256.convert(bytes);
//     String url = 'https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction';
//
//     var response = await http.post(Uri.parse(url) ,
//         body: {
//           "pp_Version": pp_ver,
//           "pp_TxnType": pp_TxnType,
//           "pp_Language": pp_Language,
//           "pp_MerchantID": pp_MerchantID,
//           "pp_Password": pp_Password,
//           "pp_TxnRefNo": tre,
//           "pp_Amount": pp_Amount,
//           "pp_TxnCurrency": pp_TxnCurrency,
//           "pp_TxnDateTime": dateandtime,
//           "pp_BillReference": pp_BillReference,
//           "pp_Description": pp_Description,
//           "pp_TxnExpiryDateTime":dexpiredate,
//           "pp_ReturnURL": pp_ReturnURL,
//           "pp_SecureHash": sha256Result.toString(),
//           "ppmpf_1":"4456733833993"
//         });
//
//     print("response=>");
//     print(response.body);
//     var res = await response.body;
//     var body = jsonDecode(res);
//     responcePrice = body['pp_Amount'];
//     AppSnackBar.snackBar(context, "payment done${responcePrice}");
//     setState(() {
//       isLoading = false;
//     });
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Home"),
//         ),
//         body: isLoading?Center(child: CircularProgressIndicator()):
//         Container(
//           child: Center(
//             child: MaterialButton(
//               onPressed: (){
//                 payment();
//               },
//               child: const Text("Click to pay JazzCash"),
//             ),
//           ),
//         )
//
//     );
//   }
// }
//


//
// class JazzCashPayment extends StatefulWidget {
//   const JazzCashPayment({super.key});
//
//   @override
//   State<JazzCashPayment> createState() => _JazzCashPaymentState();
// }
//
// class _JazzCashPaymentState extends State<JazzCashPayment> {
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     PaymentProvider paymentProvider = Provider.of<PaymentProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("JazzCash Flutter Example"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(onPressed: () {
//               payViaJazzCash(context);
//             }, child: const Text("Purchase Now !"))
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
// }
