
import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Pages/Utilities/Decoration.dart';
import 'package:hsc_app_flutter/Pages/Utilities/MyButtons.dart';

import '../LoginPage.dart';
import 'RegisterPage.dart';
import 'ResidenceSelector.dart';

class MedicaSelector extends StatefulWidget {
  const MedicaSelector({Key? key}) : super(key: key);

  @override
  State<MedicaSelector> createState() => _MedicaSelectorState();
}

class _MedicaSelectorState extends State<MedicaSelector> {
  bool visible = false;
  String medicaType = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: DecorationClass().appBar("CADASTRO"),
      body: Container(
          height: height,
          width: width,
          child: Padding(
            padding: EdgeInsets.all(width * 0.1),
            child: Column(
              children: [
                Text("Selecione o tipo de residência",
                  style: TextStyle(
                      fontSize: width * 0.07,
                      color: LoginButtonDesign.colorSec,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                Selector(
                  title: 'Ex: Clínica Médica',
                  strList: ['Clínica Médica', 'Cirurgia Geral', 'Pediatria', 'Medicina de Família e Comunidade', 'Ginecologia e Obstetrícia'],
                  onSelect: (value){
                    setState(() {
                      visible = true;
                      medicaType = value;
                    });
                  },
                ),

                SizedBox(height: 40,),
                Visibility(child: ContinueBtn(), visible: visible,)
              ],
            ),
          )
      ),
    );
  }


  Widget ContinueBtn() {
    return MainButton(
        onPressed: () => {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RegisterPage('medica',medicaType))
          )
        },
        text: 'Continuar');
  }

}


// subResidenceSelector = new  Selector(title: 'Medica',  strList: ['Escolher','Clínica Médica','Cirurgia Geral', 'Pediatria', 'Medicina de Família e Comunidade', 'Ginecologia e Obstetrícia'], controller: subResidenceController, callback: callback);
