import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hsc_app_flutter/Pages/Firebase/DataBaseService.dart';
import 'package:hsc_app_flutter/Pages/HomePage.dart';
import 'package:hsc_app_flutter/Pages/Utilities/Decoration.dart';



class DailyRecord extends StatefulWidget {
  @override
  _DailyRecordState createState() => _DailyRecordState();
}

class _DailyRecordState extends State<DailyRecord> {
  String qrCode = "null";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DecorationClass().appBar("Ponto Digital"),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 80,),
            Align(child: ScanButton(onPressed: () => scanQrCode(), text: "Registrar ponto",), alignment: Alignment.bottomCenter,),
          ],
        ),
      ),
    );
  }







  Future<void> scanQrCode() async{
    final qrCodeAns = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR
    );
    if(qrCodeAns == "-1") {     // usuário cancelou o leitor de qrcode
      return;
    }


    if(!mounted) return;

    setState(() {
      this.qrCode = qrCodeAns;
      print(this.qrCode);
    });
    checkValidation();
  }



  Future<void> checkValidation() async {
    DataBaseService().validateQRcode(qrCode).then((value) => {
      if(value){
        Navigator.of(context).pushNamed("/conf_record")
      }
      else{
        Fluttertoast.showToast(msg: "Chave inválida!", backgroundColor: Colors.grey),
        print("Chave inválida!")
      }
    });
  }




}






class ScanButton extends StatelessWidget {

  final String text;
  final Function onPressed;

  const ScanButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: DecorationClass().buttonStyle(),
      onPressed: () => onPressed(),
      child: Ink(
          decoration: BoxDecoration(
              gradient: DecorationClass().buildGradient(),
              borderRadius: BorderRadius.circular(15)),
          child: Container(
            width: 200,
            height: 40,
            alignment: Alignment.center,
            child: Text(text, style: TextStyle(fontSize: 20),),
          )),
    );
  }
}






