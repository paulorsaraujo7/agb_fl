import 'package:anjodaguardabrasil/helpers/list_of_institutions.dart';
import 'package:anjodaguardabrasil/models/institution.dart';
import 'package:anjodaguardabrasil/widgets/botton_nav_bar_main.dart';
import 'package:anjodaguardabrasil/widgets/drawer_menu_items.dart';
import 'package:anjodaguardabrasil/widgets/list_institution_item.dart';
import 'package:anjodaguardabrasil/widgets/popup_menu.dart';
import 'package:anjodaguardabrasil/helpers/lanterna.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:anjodaguardabrasil/helpers/functions.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> with WidgetsBindingObserver {
  //late AppLifecycleState _appLifecycleState;
  InstitutionType _institutionType = InstitutionType.emergence;

  @override
  void initState() {
    //print("Passei no: initState");
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    Provider.of<Lanterna>(context, listen: false).initializeCamera();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final lanternaProvider = Provider.of<Lanterna>(context, listen: false);
    /*Libera a camera quando:  ou se a lanterna estiver desligada.
      1 - a app é fechada;
      2 - a lanterna está desligada (ela pode ter sido ligada antes)
     */
    //print("Passei no: didChangeAppLifecycleState");
    //print(state);
    if (state == AppLifecycleState.detached) {
      WidgetsBinding.instance!.removeObserver(this);
      lanternaProvider.liberarCamera();
      this.dispose();
    }
  }

  @override
  void dispose() {
    // _TODO: implement dispose
    super.dispose();
  }

  //Function to handle the click on a Drawer Menu Item
  //Função que controla o clique do itens do menu Drawer

  void _drawerItemHandle(InstitutionType institutionType) {
    setState(() {
      _institutionType = institutionType;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/images/imgIconAppBar.png'),
            onPressed: () {
              Functions.launchInBrowser(
                  "https://www.gov.br/pt-br"); //PÁGINA PRINCIPAL DO GOVERNO
            },
          ),
          PopupMenu(),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return WidgetListInstitutionItem(
              _institutionType, Institutions.listOfInstitutions);
        },
      ),

      drawer: Drawer(
        child: DrawerMenuItems(
            voidCallback: _drawerItemHandle, institutionType: _institutionType),
        //_TODO (CODE): Os itens do Drawer devem vir de uma lista de Widgets onde são passado o título e função
      ),
      //bottomNavigationBar: bottomNavBar,

      bottomNavigationBar: AGB_BottomNavBarMain(),
    );
  }
}

/*


    final _kBottmonNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: const Icon(
            Icons.gps_fixed,
            size: 48,
          ),
          label: 'Onde estou',
          tooltip: 'Ver sua localização no mapa'),
      BottomNavigationBarItem(
          icon: Icon(
            lanternaProvider.isFlashModeOn
                ? Icons.wb_incandescent
                : Icons.wb_incandescent_outlined,
            size: 48,
          ),
          label: lanternaProvider.isFlashModeOn
              ? 'Desligar Lanterna'
              : 'Ligar Lanterna'),
    ];
    //assert(_kTabPages.length == _kBottmonNavBarItems.length);

     final bottomNavBar = SizedBox.fromSize(
      size: Size.fromHeight(86),
      child: BottomNavigationBar(
          items: _kBottmonNavBarItems,
          currentIndex: _currentTabIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            setState(() {
              _currentTabIndex = index;
            });
            switch (index) {
              case 0: //Onde estou
                Navigator.of(context).pushNamed(MyLocation.routeName);

                //_TODO (UX): Encontrar uma melhor forma de manter o icone da lanterna ativo.
                setState(() {
                  //Mantem o ícone da lanterna ativo
                  _currentTabIndex = 1;
                });
                break;
              case 1: //Lanterna
                  lanternaProvider.toggleFlashMode();
                break;
              default:
                break;
            }
          }),
    );

    //_TODO (CÓDIGO): Separar código do Menu Drawer em um Widget que recebe o texto e a função.
    //_TODO (UI): Deve haver o ícone para cada item do menu Drawer

 */
