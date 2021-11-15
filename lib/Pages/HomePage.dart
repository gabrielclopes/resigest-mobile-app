
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/AppWidget.dart';
import 'package:hsc_app_flutter/Pages/Firebase/AuthenticationService.dart';
import 'package:hsc_app_flutter/Pages/Firebase/DataBaseService.dart';
import 'package:hsc_app_flutter/Pages/LoginPage.dart';
import 'package:hsc_app_flutter/appController.dart';

import '../UserModel.dart';
import 'Utilities/Decoration.dart';


class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() {
    return HomePageState();
  }

}


class HomePageState extends State<HomePage> {

  final Color cor = Color(0xFF00468F);
  static double width = 0;
  static double height = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/background_home.png"), alignment: Alignment.topCenter, fit: BoxFit.fitWidth)
        ),
        width: width = MediaQuery.of(context).size.width,
        height: height = MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: (height/6)),
              ProfileIcon(),
              ButtonsGrid(),
            ],
          ),
        ),
      ),
      drawer: MainNavigationDrawer(),
    );
  }


  void closeApp() {       //close the application
    // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    // exit(0);
  }

  AppBar buildAppBar() {

    final double radius = 15;
    return AppBar(
      title: Image.asset("assets/images/resigest_logo.png",),
      centerTitle: true,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(radius))),
      actions: [
        IconButton(onPressed: () {
          // TODO: notification drawer
        }, icon: Icon(Icons.notifications_active), iconSize: 30,),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(radius)),
          gradient: DecorationClass().buildGradient(),
        ),
      ),
    );
  }



}




class MainNavigationDrawer extends StatelessWidget {
  final double mainfontSize = 17;


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: HomePageState().cor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                buildTop(context),
                SizedBox(height: 30,),
                ItemViewer("HSC", "Acessar o site"),
                ItemViewer("Suporte", "Contate o suporte técnico caso encontre erros no app"),
                ItemViewer("Política e Privacidade", "Política e privacidade do Resigest"),
              ],
            ),
            Column(children:[
              buildBottom("Sair", context),
              SizedBox(height: 10)],
            ),
          ],
        ),
      ),
    );
  }


  Widget buildTop(BuildContext context) {
    return ListTile(
        trailing: IconButton(
          icon: Icon(Icons.menu_rounded, color: Colors.white, size: 35,),
          onPressed: () => Navigator.pop(context) ,
        ),
        title: Center(
          child: Image.asset("assets/images/ResigestIcon_logo.png", height: 45,),
        ));
  }

  Widget buildBottom(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Ink(
        decoration: DecorationClass().boxDecoration(),
        child: ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.white, size: 25,),
            title: Text(title,
                style: TextStyle(
                    fontSize: this.mainfontSize,
                    color: Colors.white,
                    fontFamily: "Monstserrat",
                    fontWeight: FontWeight.bold)),
        onTap: () => AuthenticationService().signOut().then((value) => Navigator.of(context).pushNamed("/login"))
        ),
      ),
    );
  }



  // void signOut() {
  //   AuthenticationService().signOut().then((value) => Navigator.of(context).pushNamed("/login"));
  //
  // }
}



///The ItemViewer class creates and item that can be expanded when pressed
///and it has and "title" and "subtitle" parameter
class ItemViewer extends StatefulWidget {
  final String title;
  final String subtitle;

  ItemViewer(this.title, this.subtitle);

  @override
  _ItemViewerState createState() => _ItemViewerState();
}

class _ItemViewerState extends State<ItemViewer> {
  final color = Colors.white;
  final IconData extendIcon = Icons.add_circle;
  final IconData reduceIcon = Icons.remove_circle;

  bool isExtended = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Ink(
        decoration: DecorationClass().boxDecoration(),
        child: Container(
          child: !isExtended ?
          ListTile(            // QUANDO O ITEM ESTÁ RETRAÍDO
            leading: Icon(extendIcon, color: color,),
            title: Text(widget.title, style: TextStyle(color: color, fontSize: MainNavigationDrawer().mainfontSize, fontWeight: FontWeight.bold),),
            onTap: () => changeExtension(),
          ) :
          ListTile(            // QUANDO O ITEM ESTÁ EXPANDIDO E CONTÉM SUBTÍTULO
            leading: Icon(reduceIcon, color: color,),
            title: Text(widget.title, style: TextStyle(color: color, fontSize: MainNavigationDrawer().mainfontSize, fontWeight: FontWeight.bold),),
            subtitle: Text(widget.subtitle, style: TextStyle(color: color, fontSize: MainNavigationDrawer().mainfontSize - 3, fontWeight: FontWeight.normal),),
            dense: false,
            onTap: () => changeExtension(),
          ),
        ),
      ),
    );
  }

  void changeExtension() {
    setState(() {
      isExtended = !isExtended;
    });
  }
}





class ButtonsGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      padding: EdgeInsets.all(20),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      scrollDirection: Axis.vertical,
      children: buttonList(context),
    );
  }


  List<Widget> buttonList(BuildContext context) {
    double height = 40;
    double width = 40;

    return [
      InkWell(
        onTap: (){ Navigator.of(context).pushNamed("/daily_rec");},
        child: Container(
          decoration: DecorationClass().buttonsDecoration(),
          child: Center(child: Image.asset("assets/images/icons/icone_relatorio.png")),
        ),
      ),
      InkWell(
        onTap: (){ Navigator.of(context).pushNamed("/chat");},
        child: Container(
          decoration: DecorationClass().buttonsDecoration(),
          child: Center(child: Image.asset("assets/images/icons/icone_mensagens.png")),
        ),
      ),
      Container(
        width: width, height: height,
        decoration: DecorationClass().buttonsDecoration(),
        child: Center(child: Image.asset("assets/images/icons/icone_calendario.png")),
      ),
      Container(
        width: width, height: height,
        decoration: DecorationClass().buttonsDecoration(),
        child: Center(child: Image.asset("assets/images/icons/icone_avisos.png")),
      ),
    ];
  }
}


// PROFILE ICON
class ProfileIcon extends StatefulWidget {

  @override
  _ProfileIconState createState() => _ProfileIconState();
}

class _ProfileIconState extends State<ProfileIcon> {
  String _nome = '';

  @override
  Widget build(BuildContext context)  {
    return Column(
      children: [
        IconButton(onPressed: (){
          Navigator.of(context).pushNamed("/profile");
        }, icon: Icon(Icons.account_circle), iconSize: 80,),
        buildText(),
      ],
    );
  }

  Widget buildText() {
    // setNome();
    return Text(
      "Bem vindo(a)" + _nome,
      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  // void setNome() {
  //   _nome = DataBaseService().getUserData(DataBaseService.emailField);
  // }
}






