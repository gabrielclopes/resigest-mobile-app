
import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Pages/Utilities/Decoration.dart';
import 'package:hsc_app_flutter/Pages/Utilities/MyButtons.dart';

import '../LoginPage.dart';
import '../RegisterPage.dart';
import 'ResidenceSelector.dart';

class MultiSelector extends StatefulWidget {
  const MultiSelector({Key? key}) : super(key: key);

  @override
  State<MultiSelector> createState() => _MultiSelectorState();
}

class _MultiSelectorState extends State<MultiSelector> {
  String multiType = '';
  bool visible = false;


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
                title: 'Ex: Educação Física',
                strList: ['Educação Física', 'Enfermagem', 'Farmácia', 'Fisioterapia', 'Nutrição',
                  'Odontologia', 'Psicologia', 'Serviço Social', 'Enfermagem - Materno Infantil',
                  'Nutrição - Materno Infantil', 'Psicologia - Materno Infantil', 'Serviço Social - Materno Infantil'],


                onSelect: (value){
                  setState(() {
                    visible = true;
                    multiType = value;
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
              builder: (context) => RegisterPage('multi', multiType))
          )
        },
        text: 'Continuar');
  }
}


// subResidenceSelector = new Selector(title: 'Multi',  strList: ['Escolher','Farmácia','Psicologia', 'Fisioterapia'], controller: subResidenceController, callback: callback);
