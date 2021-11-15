//
// import 'Pages/Firebase/AuthenticationService.dart';
// import 'Pages/Firebase/DataBaseService.dart';
//
// class UserModel {
//   String _uid = '';
//   String _fullName = '';
//   String _email = '';
//
//   // String firstName;
//   // String profilePicUrl;
//
//
//   UserModel(){
//     setupUser();
//   }
//
//
//
//   void setupUser() {
//     String nome = "";
//     String email = "";
//     String uid = "";
//     DataBaseService().getUserdata(DataBaseService.nameField).then((value) {
//       nome = value;
//     });
//     DataBaseService().getUserdata(DataBaseService.emailField).then((value) {
//       email = value;
//     });
//     uid = AuthenticationService().getUserID();
//
//     this._email = email;
//     this._fullName = nome;
//     this._uid = uid;
//   }
//
//   String getNome() {
//     return _fullName;
//   }
//
//   String getEmail() {
//     return _email;
//   }
//
//   String getUid() {
//     return _uid;
//   }
// }