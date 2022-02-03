//
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'amount.dart';
//
// class Send extends StatefulWidget {
//   static String routeName="/send";
//   @override
//   _SendState createState() => _SendState();
// }
//
// class _SendState extends State<Send> {
//   final qrkey= GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   Barcode? barcode;
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     controller?.dispose();
//     super.dispose();
//   }
//   @override
// //  Future<void> reassemble() async {
// //    // TODO: implement reassemble
// //    super.reassemble();
// //    if(Platform.isAndroid){
// //      await controller!.pauseCamera();
// //    }
// //    controller!.resumeCamera();
// //  }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           buildQrView(context),
//           Positioned(
//             bottom: 10.0,
//               child: buildResult()),
//           Positioned(
//               bottom: 80.0,
//               child: btnNext()),
//           Positioned(
//               top: 20,
//               child: buildControlButtons())
//           ],
//       ),
//     );
//   }
//   Widget buildControlButtons()=>
//   Container(
//     padding: EdgeInsets.symmetric(horizontal: 16),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(8),
//       color: Colors.white24
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         IconButton(
//           icon: FutureBuilder<bool?>(
//             future: controller?.getFlashStatus(),
//         builder: (context,snapshot){
//           if(snapshot.data != null){
//             return Icon(
//             snapshot.data! ? Icons.flash_on : Icons.flash_off);
//           } else{
//             return Container();}
//             },
//                 ),
//           onPressed: () async{
//             await controller?.toggleFlash();
//             setState(() {
//
//               });
//             },
//         ),
//         IconButton(
//           icon: FutureBuilder(
//             future: controller?.getCameraInfo(),
//             builder: (context,snapshot){
//               if(snapshot.data != null){
//                 return Icon(Icons.switch_camera_outlined);
//               } else{
//                 return Container();}
//             },
//           ),
//           onPressed: () async{
//             await controller?.toggleFlash();
//             setState(() {
//
//             });
//           },
//         ),
//       ],
//
//     ),
//   );
//   Widget buildResult()=>
//   Container(
//     padding: EdgeInsets.all(8),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(8),
//       color: Colors.white24
//     ),
//     child: Text(
//     barcode !=null ? 'Result : ${barcode!.code}' : 'Scan a code',
//     maxLines: 3,),
//   );
//
//   Widget btnNext()=>
//       GestureDetector(
//         onTap: (){
//           pushNewScreenWithRouteSettings(
//             context,
//             settings: RouteSettings(name: Amount.routeName),
//             screen: Amount(),
//             withNavBar: true,
//             pageTransitionAnimation: PageTransitionAnimation.cupertino,
//           );
//         },
//         child: Container(
//           padding: EdgeInsets.all(8),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               color: Colors.white24
//           ),
//           child: Text(
//             'Next',
//             maxLines: 3,),
//         ),
//       );
//
//   Widget buildQrView(BuildContext context) =>
//    QRView(
//      key: qrkey,
//      onQRViewCreated: onQRViewCreated,
//      overlay: QrScannerOverlayShape(
//        borderRadius: 10,
//        borderLength: 20,
//        borderWidth: 10,
//        cutOutSize: MediaQuery.of(context).size.width * 0.8
//      ),);
//
//   void onQRViewCreated(QRViewController controller){
//     setState(()=> this.controller= controller);
//     controller.scannedDataStream.
//     listen((barcode) => setState(()=> this.barcode=barcode));
//   }
//
// }
//Column(
//children: [
//Container(
//margin: EdgeInsets.only(top: 40.0),
//child: Center(
//child: Text('Send',
//style: GoogleFonts.nunito(
//textStyle: TextStyle(
//color: Color(0xff3F51B5), fontSize: 36.0, fontWeight: FontWeight.w800)) ,),
//),
//),
//Center(
//child: Text('Scan QR code or input user name',
//style: GoogleFonts.nunito(
//textStyle: TextStyle(
//color: Color(0xff243656), fontSize: 20.0, fontWeight: FontWeight.w400)),)),
//Padding(
//padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//child: RaisedButton(
//color: Colors.blue,
//textColor: Colors.white,
//splashColor: Colors.blueGrey,
//onPressed: () {
//pushNewScreenWithRouteSettings(
//context,
//settings: RouteSettings(name: ScanScreen.routeName),
//screen: ScanScreen(),
//withNavBar: true,
//pageTransitionAnimation: PageTransitionAnimation.cupertino,
//);
//},
//child: const Text('SCAN QR CODE')
//),
//),
//],
//)