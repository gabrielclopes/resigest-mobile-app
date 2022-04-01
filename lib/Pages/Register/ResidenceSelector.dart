import 'package:flutter/material.dart';
import 'package:hsc_app_flutter/Pages/Utilities/MyButtons.dart';

import '../LoginPage.dart';
import '../Utilities/Decoration.dart';


class ResidenceSelector extends StatefulWidget {
  const ResidenceSelector({Key? key}) : super(key: key);

  @override
  _ResidenceSelectorState createState() => _ResidenceSelectorState();
}

class _ResidenceSelectorState extends State<ResidenceSelector> {
  String? residenceType;
  late Selector subResidenceSelector;
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
              Text("Selecione a área de atuação",
                style: TextStyle(
                    fontSize: width * 0.07,
                    color: LoginButtonDesign.colorSec,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40,),
              Selector(
                  title: 'Ex: Residência Médica',
                  strList: ['Residência Multidisciplinar','Residência Médica'],
                  onSelect: (value){
                    setState(() {
                      visible = true;
                      residenceType = value;
                  });},
              ),
              SizedBox(height: 40,),
              Visibility(child: ContinueBtn(), visible: visible,)
            ],
          ),
        ),
      ),
    );
  }



  Widget ContinueBtn() {
    return MainButton(
        onPressed: () => {
          if (residenceType == 'Residência Multidisciplinar'){
            Navigator.of(context).pushNamed("/resi_multi")
          }
          else {
            Navigator.of(context).pushNamed("/resi_med")
          }
        },
        text: 'Continuar');
  }

}





class Selector extends StatefulWidget {
  final String title;
  final List<String> strList;
  final Function onSelect;

  const Selector({
    Key? key,
    required this.title,
    required this.strList,
    required this.onSelect,
  })
      : super(key: key);

  @override
  State<Selector> createState() => _SelectorState();


}

class _SelectorState extends State<Selector> {
  String? _defaultValue;

  @override
  Widget build(BuildContext context) {

    List<DropdownMenuItem<String>> _itemList = widget.strList
        .map((String value) => DropdownMenuItem<String>(
      child: Text(value),
      value: value,
    ))
        .toList();

    return DropdownButton(
      hint: Text(widget.title),
      items: _itemList,
      value: _defaultValue,
      onChanged: (String? newValue){
        if (newValue != null){
          setState(() {
            _defaultValue = newValue;
            widget.onSelect(newValue);
          });
        }
      },
    );
  }




}



