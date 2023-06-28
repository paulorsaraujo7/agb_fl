import 'dart:ui';

import 'package:anjodaguardabrasil/helpers/functions.dart';
import 'package:anjodaguardabrasil/helpers/list_of_institutions.dart';
import 'package:anjodaguardabrasil/models/institution.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetListInstitutionItem extends StatelessWidget {
  final InstitutionType? _institutionType;
  final List<Institution> _listOfInstitutions;
  //final VoidCallback? makePhoneCall;

  WidgetListInstitutionItem(this._institutionType, this._listOfInstitutions);

  Future<void> _makePhoneCall(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        //TODO: (CODE AND UI): Em caso de erro, deve enviar um email para equipe técnica e exibir msg para o usuário
      }
    } catch (e) {
      //print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    //Aplica o filtro na lista de instituições de acordo com o parâmetro que é passado
    final _listOfInstitutions = Institutions.listOfInstitutions
        .where((element) => element.institutionType == _institutionType)
        .toList();
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return GestureDetector(
            child: Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 6,
              ),
              child: ListTile(
                leading: _institutionType != InstitutionType.app
                    ? Container(
                  //color: Colors.blue,
                        width: _institutionType == InstitutionType.emergence ? 90 : 103,
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          label: Text(
                            _listOfInstitutions[index].short,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          icon: Icon(Icons.call,
                              color:
                                  _institutionType == InstitutionType.emergence
                                      ? Colors.red
                                      : _institutionType ==
                                              InstitutionType.other_services
                                          ? Colors.amber
                                          : Colors.blue),
                          onPressed: () => _makePhoneCall(
                              "tel:${_listOfInstitutions[index].phone}"),
                        ),
                      )
                    : CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Image.asset(_listOfInstitutions[index].icon),
                          ),
                        ),
                      ),

                title: Text(_listOfInstitutions[index].name),
                trailing: IconButton(
                  icon: Icon(Icons.info),
                  alignment: Alignment.centerRight,
                  tooltip: "Clique aqui para mais informações",
                  //color: Theme.of(context).errorColor,
                  onPressed: () => {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(_listOfInstitutions[index].name +
                            ": " +
                            _listOfInstitutions[index].phone),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _listOfInstitutions[index].explanation,
                              textAlign: TextAlign.justify,
                            ),
                            if (_listOfInstitutions[index].url == '' ||
                                _institutionType == InstitutionType.app)
                              Text("")
                            else
                              TextButton.icon(
                                icon: const Icon(Icons.web),
                                onPressed: () => Functions.launchInBrowser(
                                    _listOfInstitutions[index].url),
                                label: const Text("Visitar site"),
                              ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton.icon(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            label: const Text('Fechar'),
                            icon: const Icon(Icons.close),
                          ),
                          TextButton.icon(
                            onPressed: () => _institutionType !=
                                    InstitutionType.app
                                ? _makePhoneCall(
                                    "tel:${_listOfInstitutions[index].phone}")
                                : Functions.launchInBrowser(
                                    _listOfInstitutions[index].url),
                            label: _institutionType != InstitutionType.app
                                ? Text('Ligar',
                                    style: TextStyle(
                                        color: _institutionType ==
                                                InstitutionType.emergence
                                            ? Colors.red
                                            : Colors.amber))
                                : Text("Ver no Google Play"),
                            icon: _institutionType != InstitutionType.app
                                ? Icon(Icons.call,
                                    color: (_institutionType ==
                                            InstitutionType.emergence)
                                        ? Colors.red
                                        : Colors.amber)
                                : Icon(Icons.play_arrow, color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  }, //leva para página de informações
                ),
              ),
            ),
            onTap: () {
              _institutionType != InstitutionType.app
                  ? _makePhoneCall("tel:${_listOfInstitutions[index].phone}")
                  : Functions.launchInBrowser(_listOfInstitutions[index].url);
            });
      },
      itemCount: Institutions.listOfInstitutions
          .where((element) => element.institutionType == _institutionType)
          .length,
    );
  }

  /*


                leading: _institutionType != InstitutionType.app
                    ? Container(
                        //color: Colors.blue,
                        transformAlignment: AlignmentDirectional.centerStart,

                        width: 100,
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: _institutionType != InstitutionType.app
                                ? TextButton.icon(
                                    label: Text(
                                      _listOfInstitutions[index].short,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    icon: Icon(Icons.call,
                                        color: _institutionType ==
                                                InstitutionType.emergence
                                            ? Colors.red
                                            : _institutionType ==
                                                    InstitutionType
                                                        .other_services
                                                ? Colors.amber
                                                : Colors.blue),
                                    onPressed: () => _makePhoneCall(
                                        "tel:${_listOfInstitutions[index].phone}"),
                                  )
                                : Image.asset(_listOfInstitutions[index].icon),
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 20,
                        backgroundColor: _institutionType == InstitutionType.app
                            ? Colors.white
                            : Colors.green,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: _institutionType != InstitutionType.app
                                ? Text(
                                    _listOfInstitutions[index].short,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )
                                : Image.asset(_listOfInstitutions[index].icon),
                          ),
                        ),
                      ),
                title: Text(_listOfInstitutions[index].name),





  @override
  Widget build(BuildContext context) {
    //Aplica o filtro na lista de instituições de acordo com o parâmetro que é passado
    final _listOfInstitutions = Institutions.listOfInstitutions
        .where((element) => element.institutionType == _institutionType)
        .toList();

    return ListView.builder(
      itemBuilder: (ctx, index) {
        return GestureDetector(
            child: Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 5,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: _institutionType == InstitutionType.app
                      ? Colors.white
                      : Colors.green,
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: FittedBox(
                      child: _institutionType != InstitutionType.app
                          ? Text(
                              _listOfInstitutions[index].short,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )
                          : Image.asset(_listOfInstitutions[index].icon),
                    ),
                  ),
                ),
                title: Text(_listOfInstitutions[index].name),
                trailing: IconButton(
                  icon: Icon(Icons.info),
                  alignment: Alignment.centerRight,
                  tooltip: "Clique aqui para mais informações",
                  //color: Theme.of(context).errorColor,
                  onPressed: () => {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(_listOfInstitutions[index].name +
                            ": " +
                            _listOfInstitutions[index].phone),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _listOfInstitutions[index].explanation,
                              textAlign: TextAlign.justify,
                            ),
                            if (_listOfInstitutions[index].url == '' ||
                                _institutionType == InstitutionType.app)
                              Text("")
                            else
                              TextButton.icon(
                                icon: const Icon(Icons.web),
                                onPressed: () => Functions.launchInBrowser(
                                    _listOfInstitutions[index].url),
                                label: const Text("Visitar site"),
                              ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton.icon(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            label: const Text('Fechar'),
                            icon: const Icon(Icons.close),
                          ),
                          TextButton.icon(
                            onPressed: () => _institutionType !=
                                    InstitutionType.app
                                ? _makePhoneCall(
                                    "tel:${_listOfInstitutions[index].phone}")
                                : Functions.launchInBrowser(
                                    _listOfInstitutions[index].url),
                            label: _institutionType != InstitutionType.app
                                ? Text('Ligar')
                                : Text("Ver no Google Play"),
                            icon: _institutionType != InstitutionType.app
                                ? Icon(Icons.call)
                                : Icon(Icons.play_arrow),
                          ),
                        ],
                      ),
                    ),
                  }, //leva para página de informações
                ),
              ),
            ),
            onTap: () {
              _institutionType != InstitutionType.app
                  ? _makePhoneCall("tel:${_listOfInstitutions[index].phone}")
                  : Functions.launchInBrowser(_listOfInstitutions[index].url);
            });
      },
      itemCount: Institutions.listOfInstitutions
          .where((element) => element.institutionType == _institutionType)
          .length,
    );
  }







   */

  /*_TODO_16/08/2021 (FEATURE): Se na explicação existir link de site, então deixá-lo funcional
    TODO (UX): Exibir formatação para as partes mais importantes da explicação
   */
}

/*
  //_TODO (FEATURE): FALTA FAZER O LINK COM A CHAMADA PARA TELA DE INFORMAÇÕES
  //_TODO_14/08/21 (FEATURE): Colocar botao na tela de explicação para ligar (chama a função como o tap. O código está nos comentários abaixo)


              showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: Text(institution!.name),
                      content: Text(
                        institution!.explanation,
                        textAlign: TextAlign.justify,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
              ).then((returnVal) {
                if (returnVal != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('You clicked: $returnVal'),
                      action: SnackBarAction(label: 'OK', onPressed: () {}),
                    ),
                  );
                }
              })

 */
