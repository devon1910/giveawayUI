
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveawayui/screens/spray_amount.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:image_picker/image_picker.dart';

class Send extends StatefulWidget {

  final String token;
  const Send({required this.token});

  @override
  _SendState createState() => _SendState();
}

class _SendState extends State<Send> {
  final qrkey= GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  final ImagePicker _picker = ImagePicker();



  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }
  @override
  Future<void> reassemble() async {
    // TODO: implement reassemble
    super.reassemble();
    if(Platform.isAndroid){
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
          Positioned(
              bottom: 10.0,
              child: buildResult()),
          Positioned(
              bottom: 80.0,
              child: ElevatedButton(
                child: Text('Next'),
                onPressed: (){
                  if(barcode != null){
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder:(context)=> SprayAmount(
                                ecode: barcode!.code,
                                token: widget.token)));
                  }
                },
              )),
          Positioned(
              top: 20,
              child: buildControlButtons())
        ],
      ),
    );
  }
  Widget buildControlButtons()=>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white24
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              icon: FutureBuilder<bool?>(
                future: controller?.getFlashStatus(),
                builder: (context,snapshot){
                  if(snapshot.data != null){
                    return Icon(
                        snapshot.data! ? Icons.flash_on : Icons.flash_off);
                  } else{
                    return Container();
                  }
                },
              ),
              onPressed: () async{
                await controller?.toggleFlash();
                setState(() {

                });
              },
            ),
            IconButton(
              icon: FutureBuilder(
                future: controller?.getCameraInfo(),
                builder: (context,snapshot){
                  if(snapshot.data != null){
                    return Icon(Icons.switch_camera_outlined);
                  } else{
                    return Container();}
                },
              ),
              onPressed: () async{
                await controller?.flipCamera();
                setState(() {

                });
              },
            ),
            IconButton(
              icon: Icon(Icons.image),
              onPressed: () async{
                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                setState(() {

                });
              },
            ),
          ],

        ),
      );
  Widget buildResult()=>
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white24
        ),
        child: Text(barcode !=null ? 'Result : ${barcode!.code}' : 'Scanning code...',
          maxLines: 3,),
      );

  Widget buildQrView(BuildContext context) =>
      QRView(
        key: qrkey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderRadius: 10,
            borderLength: 20,
            borderWidth: 10,
            cutOutSize: MediaQuery.of(context).size.width * 0.8
        ),);
  void onQRViewCreated(QRViewController controller){
    setState(()=> this.controller= controller);
    controller.scannedDataStream.listen((barcode) => setState(()=> this.barcode=barcode));
    // if(barcode != null){
    //   Navigator.of(context).push(
    //       MaterialPageRoute(
    //           builder:(context)=> SprayAmount(
    //             ecode:barcode!.code
    //               token: widget.token
    //           )));
    // }
    // controller?.dispose();

  }
}
