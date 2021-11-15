import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hsc_app_flutter/Pages/Firebase/AuthenticationService.dart';
import 'package:hsc_app_flutter/Pages/Firebase/DataBaseService.dart';
import 'package:hsc_app_flutter/Pages/Utilities/Decoration.dart';
import 'package:hsc_app_flutter/Pages/Utilities/MyButtons.dart';
import 'package:hsc_app_flutter/Pages/Utilities/MyWidgets.dart';
import 'package:geocoding/geocoding.dart';
import '../../HomePage.dart';





class ConfirmRecord extends StatefulWidget {
  @override
  _ConfirmRecordState createState() => _ConfirmRecordState();
}

class _ConfirmRecordState extends State<ConfirmRecord> {

  final DateTime datetime = new DateTime.now();
  late String _time;
  late String _date;
  late Position position;
  String _address = "-----";
  double accuracy = 0;

  Widget _continuar = CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.blue), strokeWidth: 7, );


  @override
  void initState() {
    _time = datetime.toString().substring(11,16);
    _date = datetime.toString().substring(0,10);

    getPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DecorationClass().appBar("Ponto Digital"),
      body: Center(
        child: Padding(
          padding: EdgeInsetsDirectional.only(start: 10, end: 10),
          child: Column(
            children: [
              SizedBox(height: 40,),
              UserProfile(),
              Divider(thickness: 2, indent: 10, endIndent: 10,height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(_time,
                    style: TextStyle(fontSize: 40, color: Colors.blue[800], fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  Text(_date,
                    style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Divider(thickness: 2, indent: 10, endIndent: 10,height: 30,),
              buildLocale(),
              SizedBox(height: 20,),
              _continuar,
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveInfo  () async {
    CollectionReference collection = DataBaseService.fStore.collection("user_records");
    // DocumentReference userid = collection.doc(AuthenticationService().getUserID());
    DocumentReference recordDoc = collection.doc();

    await recordDoc.set( {
      "dia" : _date,
      "hora" : _time.substring(0,2),
      "minuto" : _time.substring(3,5),
      "local": _address,
      "precisao": accuracy.toInt(),
      "user_id": AuthenticationService().getUserID()
    });



    Navigator.pop(context);
    Fluttertoast.showToast(msg: "Ponto registrado com sucesso!", backgroundColor: Colors.grey);
  }



  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getAddressFromLatLong(Position position) async{
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemark[0];

    setState(() {
      _address = '${place.street}, ${place.subLocality}';
      this.accuracy = position.accuracy;
      this._continuar = MainButton(text: "Continuar", onPressed: () => saveInfo());
    });

  }

  Future<void> getPosition()async {
    _determinePosition().then((value) {
      position = value;
      getAddressFromLatLong(position);
    }).onError((error, stackTrace) {
      print("erro: " + error.toString());
      getPosition();
    });




  }

  Widget buildLocale(){

    return Column(
      children: [
        Row(
          children: [
            //address
            Icon(Icons.location_on, size: 35,),
            Text(_address,
              style: TextStyle(fontSize: 16),),
          ],
        ),
        Row(
          children: [
            //position accuracy
            Icon(Icons.gps_fixed_outlined, size: 35,),
            Text(" Precisão de ${this.accuracy.toInt()} metros",
              style: TextStyle(fontSize: 16),)
          ],
        )
      ],
    );
  }
}

