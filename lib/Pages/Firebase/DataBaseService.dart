
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hsc_app_flutter/Pages/Firebase/AuthenticationService.dart';
import 'package:hsc_app_flutter/Pages/HomeOptions/ProfilePage.dart';

class DataBaseService {

  static final fStore = FirebaseFirestore.instance;
  static final fStorage = FirebaseStorage.instance;

  static final String userCollection = "user";
  static final String keyCollection = "keys";


  static final String nameField = "nome_completo";
  static final String emailField = "email";
  static final String residenceTypeField = "residence_type";
  static final String residenceNameField = "residence_field";
  static final String inHospitalField = "registrando_horas";


  Future<void> addUserDocument(String nome, String email, String field, String type) async {
    CollectionReference collection = fStore.collection(userCollection);

    DocumentReference userDoc = collection.doc(AuthenticationService().getUserID());

    await userDoc.set( {
      nameField : nome,
      emailField : email,
      inHospitalField: false,
      residenceTypeField: type,
      residenceNameField: field
    });

  }

  Future<String> retrieveUserPic() async {
    String fileName = ProfilePage.picFolder + AuthenticationService().getUserID() + "_pic";

    var child = DataBaseService.fStorage.ref().child(fileName);
    try {
      return await child.getDownloadURL();
    }catch(error){
      print("erro: " + error.toString());
      return "nao";
    }

  }





  Future getUserData() async {
    try {
      DocumentSnapshot dSnap = await fStore.collection(userCollection).
      doc(AuthenticationService().getUserID()).get();

      String name = dSnap.get(nameField);
      String email = dSnap.get(emailField);
      return [name, email];

    } catch(e) {
      print("erro: " + e.toString());
      return null;
    }
  }
  static Future<void> updateStatus(bool insideHospital) async {
    CollectionReference collection = fStore.collection(userCollection);

    DocumentReference userDoc = collection.doc(AuthenticationService().getUserID());

    await userDoc.set( {
      inHospitalField: insideHospital
    },
        SetOptions(merge: true)
    );
  }



  static Future<bool> isInsideHospital() async {
    try {
      DocumentSnapshot dSnap = await fStore.collection(userCollection).
      doc(AuthenticationService().getUserID()).get();

      bool isInside = dSnap.get(inHospitalField);
      return isInside;

    } catch(e) {
      print("erro: " + e.toString());
      return false;
    }
  }


  Future<bool> validateQRcode(String code) async {
    bool valid = false;
    CollectionReference collection = fStore.collection(keyCollection);

    await collection
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if(code.compareTo(doc["chave"].toString()) == 0){
          valid = true;
        }
      });
    });


    return valid;
  }





}