import 'package:anjodaguardabrasil/screens/politica_privacidade.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './screens/user_location.dart';
import './screens/about.dart';
import './helpers/lanterna.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Lanterna>(
            create: (ctx) => Lanterna(),
          ),
          /*O ChangeNotifierProvider tem a propriedade child que indica qual o
        * widget deve ser avisado sobre as notificações. OBs.: apenas os que estiverem
        * interessados, registrados como observadores*/
        ],
        child: MaterialApp(
            title: 'Anjo da Guarda',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.green,
              buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Colors.blue,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            home: Home(title: 'Anjo da Guarda'),
            routes: {
              MyLocation.routeName: (ctx) => MyLocation(),
              About.routeName: (ctx) => About(),
              PoliticaPrivacidade.routeName: (ctx) => PoliticaPrivacidade(),
            }));
  }
}


/*
*   _xTODO (P): A lanterna está apagando quando é mudada a rotação da tela e mesmo apagada o recurso continua preso R: resolvido
    {Possível solução: armazenar no sharedpreferences o estado do flash ao sair do app. qndo voltar, ativar se necessário}
    _xTODO (ERRO): Ao sair do app, tem que liberar a câmera se estiver apagada.

*   _pTODO (P): Dividir os widgets:
      {_Feito_Parcialmente em 10/08/21, 05/09/21, 06/09/21}
*   _TODO (P UX): O botão da lanterna não está atualizando propriamente quando a tela é rotacionada ou quando o app retomado após voltar para ele quando sai pelo botão voltar da tela principal
*   TODO (CÓDIGO): 1 - Todas as strings do app devem vir de uma classe ou enum
*   TODO (CÓDIGO): 2 - Todas as classes interessadas devem usar provider
*   TODO (CÓDIGO): 3 - Todo código e comentários devem estar em inglês
*
*   TODO (FEATURE): 5 - Compartilhar o link para baixar o app
*   TODO (FEATURE): 6 - Avaliar o app na PlayStore
*   TODO (FEATURE): 8 - Deve haver a possibilidade de adquirir a versão pro (API purchase in app)
*   TODO (GERAL UX):  9 - As mudanças de telas usam as transições utilizadas no app MyShop
*   TODO (GERAL UX):  10 - As cores primárias do app devem ser as da bandeira do Brasil (app bar: verde, banner...)
*   TODO (GERAL UX):  11 - Cores da logo: Auréola: branco, Bottom: verde ou azul, banner: cor verde em gradiente (colcar em marca d'agua o dizer da bandeira do Brasil?)
*   TODO (GERAL UX):  12 - Tela de splash com mensagem na abertura e cores da bandeira do Brasil
*   TODO (GERAL UX?): 13 - Primeira utilização abre telas de introdução com explicações rápidas



*   _TODO (P)_05/09/21: A lanterna deve ser controlada fora da main
{
}

*   _TODO (P)_05/09/21: A lanterna só deve segurar o recurso depois de exibir a tela inicial (está prendendo quando da abertura do app) R: vai segurar na abertura do app*
*   _TODO (P)_23/08/21: As listas não estão exibindo os últimos itens (tem a solução em alguma das aulas){
        SOLUÇÃO...
        Container(
              height: MediaQuery.of(context).size.height - bottomNavBar.height!.toDouble() - 10,
              (Bottombar numa sizedbox e diminuir o tamanho no container que conterá a lista )
     }
*   _TODO (FEATURE): - Lanterna
*   _TODO_100821 (FEATURE): 5 - As listas de telefones devem estar funcionais
*   _TODO_100821 (FEATURE): 5.1 - Criar a tela ou dialog box sobre as informações para cada instituição
    _TODO (FEATURE): 7 - Tela sobre (usar a animation hero)
      {Parcialmente feito em 15/08/2021
       Concluído em 23/08/2021
      }


*

/*
*/
              /*
          bottomNavigationBarTheme: BottomNavigationBarTheme.of(context).copyWith(
            backgroundColor: ColorSwatch(500, _swatch),
          ),
           */

              //primaryColorLight: Color.fromRGBO(0, 39, 118, 1),
              //backgroundColor: Colors.pink,
              //accentColor: Colors.blueAccent,
              //accentColorBrightness: Brightness.dark,


 */

/*             Card(
              elevation: 6,
              margin: EdgeInsets.all(5),
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    //const SizedBox(width: 8),
                    TextButton(
                      child: const Text('ONDE ESTOU'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(MyLocation.routeName);
                      },
                    ),

                    ElevatedButton(
                      child: const Text('LIGAR'),
                      onPressed: null,
                    ),
                  ],
                ),
              ),
            ),
            *
            *
            *
      floatingActionButton: FloatingActionButton(
        onPressed: _controller != null
            ? _isFlashModeOn
                ? () => onSetFlashModeButtonPressed(FlashMode.off)
                : () => onSetFlashModeButtonPressed(FlashMode.torch)
            : null,
        tooltip: _isFlashModeOn ? 'Ligar Laterna' : 'Desligar Lanterna',
        child: _controller != null
            ? _isFlashModeOn
                ? Icon(Icons.wb_incandescent)
                : Icon(Icons.wb_incandescent_outlined)
            : null,
      ),
      *

*    //_TODO (CODE): usar enum para os itens da bottom bar para evitar erros
    final _kTabPages = <Widget>[
      const Center(child: Icon(Icons.cloud, size: 64.0, color: Colors.teal)),
      const Center(child: Icon(Icons.alarm, size: 64.0, color: Colors.cyan)),
    ];

*
*
       appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.directions_bus),
            onPressed: () {},
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(child: Text('Boat')),
                const PopupMenuItem(child: Text('Train'))
              ];
            },
          )
        ],
      ),

              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return WidgetListInstitutionItem(
                    institution: Institutions.listOfInstitutions
                        .where((element) =>
                            element.institutionType == _institutionType)
                        .toList()[index],
                    makePhoneCall: () => _makePhoneCall(
                        "tel:${Institutions.listOfInstitutions[index].phone}"),
                  );
                },
                itemCount: Institutions.listOfInstitutions
                    .where((element) =>
                        element.institutionType == _institutionType)
                    .length,
              ),

  /*
  Future<void> _makePhoneCall(String url) async { //Essa função poderia ficar no widget que desenha o item?
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        //TODO: (CODE AND UI): Em caso de erro, deve enviar um email para equipe técnica e exibir msg para o usuário
      }
    } catch (e) {
      print(e.toString());
    }
  }
  */

 */

/* verificar a diponibilidade de lanterna
      se existir:
        diponibiliza o botão
          Se usuário pressionar o botão para ligar a lanterna
            tenta separar e ativar o recurso
              Se der erro
                Informa ao usuário
              se não der erro
                acende a lanterna e muda o status da variável de controle da lanterna para ativada
      se não existir:
        disponibiliza o botão desabilitado e informa ao usuário que não está disponível lanterna no aparelho dele

    FUNCÕES NECESSÁRIAS
      para verificar a existência da lanterna. Seta um booleano
      para separar e ativar o recurso. Seta um booleano para informar se o recurso existe e inicializado
      para informar ao usuário sobre algum erro em algumas das funções acima
      para setar o tipo de flash. seta um booleano que informa se a lanterna está ativa
      para verificar se o flash está ligado. retorna um booleano que indica se o flash está ativo






void main() async {
  runApp(MyApp());
}


Map<int, Color> _color =
{
  50:Color.fromRGBO(0, 39, 118, .1),
  100:Color.fromRGBO(0, 39, 118, .2),
  200:Color.fromRGBO(0, 39, 118, .3),
  300:Color.fromRGBO(0, 39, 118, .4),
  400:Color.fromRGBO(0, 39, 118, .5),
  500:Color.fromRGBO(0, 39, 118, .6),
  600:Color.fromRGBO(0, 39, 118, .7),
  700:Color.fromRGBO(0, 39, 118, .8),
  800:Color.fromRGBO(0, 39, 118, .9),
  900:Color.fromRGBO(0, 39, 118, 1),

};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor myColor = MaterialColor(0xFF002776, _color);
    return MaterialApp(
        title: 'Anjo da Guarda',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(



          //primaryColorLight: Color.fromRGBO(0, 39, 118, 1),

          //primaryColorLight: Color.fromRGBO(0, 39, 118, 0),
          //primarySwatch: myColor,





  */
