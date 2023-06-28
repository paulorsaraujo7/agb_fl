import 'package:anjodaguardabrasil/helpers/functions.dart';
import 'package:anjodaguardabrasil/models/institution.dart';
import 'package:anjodaguardabrasil/screens/about.dart';
import 'package:anjodaguardabrasil/screens/politica_privacidade.dart';
import 'package:anjodaguardabrasil/screens/user_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'drawer_menu_item.dart';

class DrawerMenuItems extends StatelessWidget {
  const DrawerMenuItems(
      {Key? key, required this.voidCallback, required this.institutionType})
      : super(key: key);

  final void Function(InstitutionType) voidCallback;
  final InstitutionType institutionType;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          height: 200,
          width: 200,
          color: Colors.amberAccent,
          alignment: Alignment.center,
          child: Column(
            children: [
              Image.asset(
                'assets/images/imgLogoFlagBrazil.png',
                height: 200,
              ),
              //Text("Anjo da Guarda"),
            ],
          ),
        ),
        DrawerMenuItem(
            title: "Emergências",
            voidCallback: voidCallback,
            institutionType: InstitutionType.emergence),
        DrawerMenuItem(
            title: "Outros Serviços",
            voidCallback: voidCallback,
            institutionType: InstitutionType.other_services),
        DrawerMenuItem(
            title: "Apps do Governo do Brasil",
            voidCallback: voidCallback,
            institutionType: InstitutionType.app),
        ListTile(
          title: Text("Minha Localização"),
          leading: Icon(
            Icons.gps_fixed,
            color: Colors.green,
          ),
          onTap: () => {Navigator.of(context).pushNamed(MyLocation.routeName)},
        ),
        Divider(
          thickness: 2,
        ),
        ListTile(
          title: Text("Entrar em contato"),
          leading: Icon(Icons.mail),
          onTap: () {
            String? encodeQueryParameters(Map<String, String> params) {
              return params.entries
                  .map((e) =>
                      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                  .join('&');
            }

            final Uri emailLaunchUri = Uri(
              scheme: 'mailto',
              path: 'suporte@deftrue.com',
              query: encodeQueryParameters(
                  <String, String>{'subject': 'Suporte ao usuário.'}),
            );
            Functions.launchInBrowser(emailLaunchUri.toString());
          },
        ),
        ListTile(
          title: Text("Política de Privacidade"),
          leading: Icon(Icons.shield),
          onTap: () => Functions.launchInBrowser(
              "https://www.deftrue.com/privacy_police.php"),
          //{Navigator.of(context).pushNamed(PoliticaPrivacidade.routeName)},
        ),
        ListTile(
          title: Text("Sobre"),
          leading: Icon(Icons.announcement),
          onTap: () => {Navigator.of(context).pushNamed(About.routeName)},
        ),
        ListTile(
          title: Text("Recomendar este app"),
          leading: Icon(Icons.share),
          onTap: () => Functions.onShareLinkApp(context),
        ),
        ListTile(
          title: Text("Avaliar o app"),
          leading: Icon(Icons.star),
          onTap: () => Functions.launchInBrowser(
              "https://play.google.com/store/apps/details?id=com.idyoou.anjodaguardabrasil"),
          //{Navigator.of(context).pushNamed(PoliticaPrivacidade.routeName)},
        ),
        ListTile(
          title: Text("Sair"),
          leading: Icon(Icons.exit_to_app),
          onTap: () => {SystemNavigator.pop()},
        ),
      ],
    );
  }
}

/*


        UserAccountsDrawerHeader(
          accountName: Text(
            'Anjo da Guarda',
            style: TextStyle(color: const Color(0xFFFFFFFF), fontSize: 20),
          ),
          accountEmail: Text(''),
          currentAccountPicture: CircleAvatar(
            child: Image.asset('assets/images/imgLogoAnjo.png'),
          ),
        ),



        UserAccountsDrawerHeader(
          accountName: Text('User Name'),
          accountEmail: Text('user.name@email.com'),
          currentAccountPicture: CircleAvatar(
            child: FlutterLogo(size: 42.0),
            backgroundColor: Colors.white,
          ),
          /*otherAccountsPictures: <Widget>[
        CircleAvatar(
          child: Text('A'),
          backgroundColor: Colors.yellow,
        ),
        CircleAvatar(
          child: Text('B'),
          backgroundColor: Colors.red,
        )
      ],*/
        ),
        DrawerMenuItem(
        ...
 */
