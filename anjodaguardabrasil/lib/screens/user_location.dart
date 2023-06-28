import 'dart:convert';
import 'package:android_intent/android_intent.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:anjodaguardabrasil/helpers/lanterna.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'dart:async';
import 'package:share_plus/share_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

//COM BASE NAS VARIÁVEIS DIVERSAS QUAL O TIPO DE ENDEREÇO QUE SE PODE OBTER
enum FinalStatusUserLocation {
  NONE, //NÃO PODE OBTER ENDEREÇO
  ONLY_LATLNG, //SOMENTE AS COORDENADAS
  COMPLETE, //ENDEREÇO COMPLETO
}

class MyLocation extends StatefulWidget {
  static const routeName = '/my-location';

  @override
  _MyLocation createState() => _MyLocation();
}

class _MyLocation extends State<MyLocation> {
  //VARIÁVEIS DE CONTROLE SOBRE STATUS DO GPS E ACESSO A NET
  var _permissionGPSAccepted = false;
  var _isGPSOn = false;
  var _permissionNETAccepted = false; //NÃO ESTÁ SENDO USADA POR ENQUANTO
  var _isNETOn = false;
  var _finalStatusToGetUserLocation = FinalStatusUserLocation.NONE;

  String _currentUserAddressComplete = ""; //ENDEREÇO COMPLETO POR EXTENSO
  String _currentUserAddressLatLng = ""; //ENDEREÇO COMPLETO SÓ LATLNG
  String _URLCurrentUserAddressComplete =
      ""; //URL ENDEREÇO COMPLETO POR EXTENSO
  String _URLCurrentUserAddressLatLng = ""; //URL ENDEREÇO COMPLETO SÓ LATLNG
  String _finalCurrentUserAddress = ""; //ENDEREÇO COMPLETO POR EXTENSO
  String _URLFinalCurrentUserAddress = ""; //URL ENDEREÇO COMPLETO SÓ LATLNG

  //FIM - VARIÁVEIS DE CONTROLE SOBRE STATUS DO GPS E ACESSO A NET

  //VARIÁVEIS DE CONTROLE VINDAS DO FRAMEWORK
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  loc.Location location = new loc.Location();
  var _locationServiceEnabled = false;
  late loc.PermissionStatus _locationPermissionStatus;
  late loc.LocationData _locationData;

  Completer<GoogleMapController> _completerGoogleMapController = Completer();
  late CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(0.0, 0.0), zoom: CAMERA_ZOOM);
  MapType _currentMapType = MapType.normal;

  final Permission permission = Permission.byValue(3);
  late Map<Permission, PermissionStatus> mapPermissionPermissionStatus;
  //FIM - VARIÁVEIS DE CONTROLE VINDAS DO FRAMEWORK

  static const CAMERA_ZOOM = 18.0;

  Future<bool> _requestPermission(Permission permission) async {
    final Permission _permission = Permission.byValue(permission.value);
    var result = await _permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

/*Checking if your App has been Given Permission*/
  Future<bool> requestLocationPermission({required Function onPermissionDenied}) async {
    var granted = await _requestPermission(Permission.location);
    if (granted != true) {
      requestLocationPermission(onPermissionDenied: (){});
    }
    //debugPrint('requestContactsPermission $granted');
    _permissionGPSAccepted = true;
    return granted;
  }

/*Show dialog if GPS not enabled and open settings location*/
  Future _checkGps() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Não é possível obter a localização atual."),
                content:
                    const Text('Tente ligar o GPS e tentar novamente.'),
                actions: <Widget>[
                  FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        final AndroidIntent intent = AndroidIntent(
                            action:
                                'android.settings.LOCATION_SOURCE_SETTINGS');
                        intent.launch();
                        Navigator.of(context, rootNavigator: true).pop();
                        _gpsService();
                      })
                ],
              );
            });
      }
    }
  }

/*Check if gps service is enabled or not*/
  Future _gpsService() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      _checkGps();
      return null;
    } else {
      _isGPSOn = true;
      return true;
    }
  }


/*Check if gps service is enabled or not*/



  ///Tem a função de checar e atualizer as VARIÁVEIS GLOBAIS de controle
  ///sobre o status do GPS e do acesso à INTERNET
  ///SAÍDA: A saíde é a definição da variável global
  ///_finalStatusToGetUserLocation
  Future<void> _getFinalStatusUserLocation() async {
    //INICIALIZA NEGADAS TODAS AS VARIÁVEIS DE STATUS
    _permissionGPSAccepted = false;
    _isGPSOn = false;
    _permissionNETAccepted = false;
    _isNETOn = false;
    _finalStatusToGetUserLocation = FinalStatusUserLocation.NONE;
    //FIM - INICIALIZA NEGADAS TODAS AS VARIÁVEIS DE STATUS

    //CHECAR STATUS DA NET
    //TODO: FALTA CHECAR AS PERMISSÕES DA NET
    //VERIFICA SE A NET ESTÁ ATIVA
    try {
      _connectivityResult = await _connectivity
          .checkConnectivity(); //Verificar o status da conexão
    } on PlatformException catch (e) {
      //TODO: tratar melhor o erro de plataforma. Talvez solicitar o usuário para que reinicie o app
      //print(e.toString());
    }
    if (_connectivityResult == ConnectivityResult.wifi ||
        _connectivityResult == ConnectivityResult.mobile ||
        _connectivityResult == ConnectivityResult.ethernet) {
      //To render correctly the widget tree
      _isNETOn = true;
    }
    //FIM - CHECAR STATUS DA NET


    if (await requestLocationPermission(onPermissionDenied: (){})){
      _isGPSOn = true;
      _permissionGPSAccepted = true;
    }

    //CHECAR STATUS DO GPS

    /*
    //LIGADO OU NAO
    _locationServiceEnabled =
    await location.serviceEnabled(); //QUAL O STATUS DO GPS
    if (_locationServiceEnabled) _isGPSOn = true; // SE ATIVO ENTÃO TRUE
    if (!_locationServiceEnabled) {
      //SE NÃO ATIVO, SOLICITA O SERVIÇO
      _locationServiceEnabled = await location.requestService();
      if (!_locationServiceEnabled) {
        // SE NÃO ATIVO, ENTÃO FALSE
        _isGPSOn = false; //JÁ COMEÇA NEGADO. ESTÁ REDUNDANTE
      }
    }
    //FIM - CHECAR STATUS DO GPS





    //TRATAMENTO DAS PERMISSÕES DO GPS
    _locationPermissionStatus =
        await location.hasPermission(); //QUAL A PERMISSÃO VIGENTE
    if (_locationPermissionStatus == loc.PermissionStatus.granted ||
        _locationPermissionStatus == loc.PermissionStatus.grantedLimited) {
      //ESTÁ PERMITIDA
      _permissionGPSAccepted = true;
    }
    if (_locationPermissionStatus == loc.PermissionStatus.denied ||
        _locationPermissionStatus == loc.PermissionStatus.deniedForever) {
      //ESTÁ NEGADA
      _locationPermissionStatus =
          await location.requestPermission(); // SOLICITA PERMISSÃO
      if (_locationPermissionStatus == loc.PermissionStatus.denied ||
          _locationPermissionStatus == loc.PermissionStatus.deniedForever) {
        //FOI NEGADA
        _permissionGPSAccepted = false;
      }
    }
     */

    //TODO 17/09/2021 (UX): Falta tratar o caso de o usuário não aceitar o acesso à rede (ver a tabela no excel)
    //DEFINIR A VARIÁVEL GLOBAL QUE INDICA O TIPO DE ENDEREÇO QUE PODE SER OBTIDO
    if (_isGPSOn && _permissionGPSAccepted && _isNETOn) {
      _finalStatusToGetUserLocation = FinalStatusUserLocation.COMPLETE;
    }
    if (_isGPSOn && _permissionGPSAccepted && !_isNETOn) {
      _finalStatusToGetUserLocation = FinalStatusUserLocation.ONLY_LATLNG;
    }



    //SE A ÁRVORE DE WIDGET ESTIVER MONTADA, ENTÃO
    // ATUALIZA A ÁRVORE DE WIDGET QUE PODE ESTÁ INTERESSADA NOS VALORES DAS VARS
    if (!mounted) {
      //ARVORE NÃO MONTADA
      return Future.value(null);
    }

    //chama a função que vai atualizar a árvore de widget
    return _updateConnectionStatus(_connectivityResult);


  } // FIM - Future<void> _checkFinalStatusUserLocation() async...

  ///Função que está registrada para "ouvir" mudanças na conexão com a net
  Future<void> _updateConnectionStatus(
      ConnectivityResult connectivityResult) async {
    //If changed to online, then update the current address;
    _connectivityResult = connectivityResult;
    //Se conexão
    if (_connectivityResult ==
        ConnectivityResult.none) //To render correctly the widget tree
    {
      setState(() {
        _isNETOn = false;
      });
    }
    if (_connectivityResult == ConnectivityResult.wifi ||
        _connectivityResult == ConnectivityResult.mobile ||
        _connectivityResult ==
            ConnectivityResult.ethernet) //To render correctly the widget tree
    {
      setState(() {
        _isNETOn = true;
      });
    }
  }

  ///Retorna uma String com os endereços de localização do usuário. Extenso e URL
  ///1 - O endereço completo por extenso e sua URL
  ///ou
  ///2 - O endereço no formato latitude e longitude e sua URL
  Future<void> _getCurrentUserAddressess({bool completeAddress = false}) async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }
    await _getFinalStatusUserLocation(); //ATUALIZA AS VARIÁVEIS DE STATUS
    //NÃO HÁ COMO OBTER QUAISQUER DOS ENDEREÇOS
    if (_finalStatusToGetUserLocation == FinalStatusUserLocation.NONE) {
      _URLCurrentUserAddressComplete = "";
      _URLCurrentUserAddressLatLng = "";
      _currentUserAddressComplete = "";
      _currentUserAddressLatLng = "";

      _finalCurrentUserAddress = "";
      _URLFinalCurrentUserAddress = "";
    }

    LatLng latLng = _cameraPosition.target;
    String latitude = latLng.latitude.toString();
    String longitude = latLng.longitude.toString();

    //HÁ COMO OBTER SOMENTE LATLNG
    if (_finalStatusToGetUserLocation == FinalStatusUserLocation.ONLY_LATLNG) {
      _URLCurrentUserAddressLatLng =
          'https://www.google.com.br/maps/@$latitude,$longitude,17z';
      _URLCurrentUserAddressLatLng =
          Uri.parse(_URLCurrentUserAddressLatLng).toString();
      _currentUserAddressLatLng = "Latitude: $latitude, Longitude:$longitude";

      _finalCurrentUserAddress = _currentUserAddressLatLng;
      _URLFinalCurrentUserAddress = _URLCurrentUserAddressLatLng;
    }

    //HÁ COMO OBTER O ENDEREÇO COMPLETO
    if (_finalStatusToGetUserLocation == FinalStatusUserLocation.COMPLETE &&
        completeAddress) {
      //TODO: A chave de acesso a API deve ser escondida
      _URLCurrentUserAddressComplete =
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyDFdGq-K6n8MoKzUUE3RXlGj0McdELNRgk";
      http.Response response =
          await http.get(Uri.parse(_URLCurrentUserAddressComplete));
      Map<String, dynamic> retorno = json.decode(response.body);
      _currentUserAddressComplete = retorno['results'][0]['formatted_address'] +
          '\n' +
          'Latitude: ' +
          retorno['results'][0]['geometry']['location']['lat'].toString() +
          ", " +
          ' Longitude: ' +
          retorno['results'][0]['geometry']['location']['lng'].toString();
      _URLCurrentUserAddressComplete = Uri.parse(
              "https://www.google.com/maps/search/?api=1&query=$_currentUserAddressComplete")
          .toString();

      _finalCurrentUserAddress = _currentUserAddressComplete;
      _URLFinalCurrentUserAddress = _URLCurrentUserAddressComplete;
    }

    /*
    print("Da função _currentUserURLAddressComplete: " +
        _URLCurrentUserAddressComplete);
    print("Da função _currentUserURLAddressLatLng: " +
        _URLCurrentUserAddressLatLng);
    print("Da função _currentUserAddressComplete: " +
        _currentUserAddressComplete);
    print("Da função _currentUserAddressLatLng: " + _currentUserAddressLatLng);
    print("Da função _finalCurrentUserAddress: " + _finalCurrentUserAddress);
    print("Da função _URLFinalCurrentUserAddress: " +
        _URLFinalCurrentUserAddress);

     */

    //ATUALIZA A ARVORE DE WIDGETS SE ESTIVER MONTADA
    if (this.mounted) {
      setState(() {});
    }
    return Future.value(null);
  }

  ///Cria a caixa de compartilhamento da localização do usuário
  ///OUT: Caixa de compartilhamento com o endereço a ser compartilhado
  Future<void> _onShare(BuildContext context) async {
    //ATUALIZA OS ENDEREÇOS POSSÍVEIS
    await _recuperarLocalizacaoAtual(completeAddress: true);
    final box = context.findRenderObject() as RenderBox?;

    await Share.share(
        _finalCurrentUserAddress + '\n' + _URLFinalCurrentUserAddress,
        subject: 'Minha localização: ',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    return Future.value(null);
    //TODO(PENDÊNCIA): Se não houver um endereço válido por falta de internet por exemplo, então envia mensagem apenas com a latitude e longitude, se houver
    //TODO(PENDÊNCIA): Se não houver nem latitude nem logitude, então envia uma mensagem padrão
    //TODO(PENDÊNCIA): Definir qual a mensagem padrão para quando não existir dados de localização a serem compartilhados

  }

  Future<void> _onMapCreated(GoogleMapController googleMapController) async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }
    //await _getFinalStatusUserLocation(); //VERIFICA AS VARIÁVEIS DE STATUS
    //if (_finalStatusToGetUserLocation == FinalStatusUserLocation.COMPLETE)

    _completerGoogleMapController.complete(googleMapController);
    _recuperarLocalizacaoAtual(completeAddress: true);
  }

  Future<void> _recuperarLocalizacaoAtual({GoogleMapController? googleMapController,
      bool completeAddress = false}) async {
    //SE A ÁRVORE DE WIDGET AINDA NÃO ESTÁ MONTADA, EXIT
    if (!mounted) {
      return Future.value(null);
    }
    await _getFinalStatusUserLocation();
    //É POSSÍVEL SOLICITAR UM ENDEREÇO



    if (_finalStatusToGetUserLocation != FinalStatusUserLocation.NONE) {
      _locationData = await location.getLocation();
      //RECUPERA POSIÇÃO DO USUÁRIO COM LATITUDE E LONGITUDE
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 5));

      _cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: CAMERA_ZOOM);

      if (!completeAddress) {
        await _getCurrentUserAddressess(completeAddress: false);
      }
      //SOLICITA ENDEREÇO COMPLETO POR EXTENSO E SAI.
      if (completeAddress &&
          _finalStatusToGetUserLocation == FinalStatusUserLocation.COMPLETE) {
        await _getCurrentUserAddressess(completeAddress: true);
        return;
      }
    }
    //NÃO É POSSÍVEL SOLICITAR UM ENDEREÇO (PODE SER GPS OU NET DESLIGADOS POR EXEMPLO)
    else {
      //TODO: TRATAR A RESPOSTA PARA O USUÁRIO

    }
    _completerGoogleMapController.complete(googleMapController);
    _movimentarCamera();
    setState(() {

    });
  }

  Future<void> _movimentarCamera() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    if (!mounted) {
      return Future.value(null);
    }

    GoogleMapController googleMapController =
        await _completerGoogleMapController.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  void _adicionarListenerLocalizacao() {
    Geolocator.getPositionStream().listen((Position position) {
      if (this.mounted) {
        //setState(() { //se ativar o setstate, então gera atualizações desnecessárias (NÃO FAZER!!)
        _cameraPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: CAMERA_ZOOM);

        //LOGO APÓS A ACEITAÇÃO DA PERMISSÃO, ENTÃO REDESENHA O MAPA NA TELA
        if (_currentUserAddressComplete == ""){
          _recuperarLocalizacaoAtual(completeAddress: true);
          _movimentarCamera(); //SE TIRAR NÃO CARREGA O MAPA APÓS ACEITAR AS PERMISSÕES. FICA RECENTRALIZANDO NO MAPA
        }



        //});
      }
    });
  }

  void _openOnMaps(BuildContext context) async {

    _recuperarLocalizacaoAtual(completeAddress: true);
    //if (_finalStatusToGetUserLocation == FinalStatusUserLocation.NONE) {
    //  return;
    //}

    if (_finalStatusToGetUserLocation == FinalStatusUserLocation.COMPLETE) {
      await _getCurrentUserAddressess(completeAddress: true);
      _URLFinalCurrentUserAddress = _URLCurrentUserAddressComplete;
    }

    if (_finalStatusToGetUserLocation == FinalStatusUserLocation.ONLY_LATLNG) {
      await _getCurrentUserAddressess(completeAddress: false);
      _URLFinalCurrentUserAddress = _URLCurrentUserAddressLatLng;
    }

    if (await canLaunch(_URLFinalCurrentUserAddress)) {
      await launch(
        _URLFinalCurrentUserAddress,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $_URLFinalCurrentUserAddress';
    }
    return;
  }

  @override
  void initState() {
    super.initState();
    //_getFinalStatusUserLocation(); //TENTA INICIALIZAR OS SERVIÇOS NECESSÁRIOS
    //DEFINE UM LISTENER PARA MUDANÇA DO STATUS DA NET
    _adicionarListenerLocalizacao();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _recuperarLocalizacaoAtual(completeAddress: true);
    _movimentarCamera();
    setState(() {

    });
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
    _completerGoogleMapController.future
        .then((value) => value.dispose()); //libera recursos do mapa
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //_getFinalStatusUserLocation(); //TENTA INICIALIZAR OS SERVIÇOS NECESSÁRIOS
    //DEFINE UM LISTENER PARA MUDANÇA DO STATUS DA NET
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _recuperarLocalizacaoAtual(completeAddress: true);
    _movimentarCamera();
    setState(() {

    });
  }

  @override
  void resumed(AppLifecycleState state) {
    //_getFinalStatusUserLocation(); //TENTA INICIALIZAR OS SERVIÇOS NECESSÁRIOS
    //DEFINE UM LISTENER PARA MUDANÇA DO STATUS DA NET
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _recuperarLocalizacaoAtual(completeAddress: true);
    _movimentarCamera();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    /*
    print("_permissionGPSAccepted: " + _permissionGPSAccepted.toString());
    print("_isGPSOn: " + _isGPSOn.toString());
    print("_permissionNETAccepted: " + _permissionNETAccepted.toString());
    print("_isNETOn: " + _isNETOn.toString());
    print("_finalStatusToGetUserLocation: " +
        _finalStatusToGetUserLocation.index.toString());

    print("_currentUserURLAddressComplete: " + _URLCurrentUserAddressComplete);
    print("_currentUserURLAddressLatLng: " + _URLCurrentUserAddressLatLng);
    print("_currentUserAddressComplete: " + _currentUserAddressComplete);
    print("_currentUserAddressLatLng: " + _currentUserAddressLatLng);
    print("_finalCurrentUserAddress: " + _finalCurrentUserAddress);
    print("_URLFinalCurrentUserAddress: " + _URLFinalCurrentUserAddress);

    _getCurrentUserAddressess();
    var currentUserAddress = "";
    if (_finalStatusToGetUserLocation == FinalStatusUserLocation.COMPLETE) {
      currentUserAddress = _currentUserAdressComplete;
    }
    if (_finalStatusToGetUserLocation == FinalStatusUserLocation.ONLY_LATLNG) {
      currentUserAddress = _currentUserAdressLatLng;
    }
     */

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sua localização é: "),
      ),
      body: Stack(
        children: <Widget>[
          _connectivityResult != ConnectivityResult.none
              ? GoogleMap(
                  mapType: _currentMapType,
                  initialCameraPosition: _cameraPosition,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: true,
                  indoorViewEnabled: true,
                  trafficEnabled: true,
                  onTap: (_) {
                      _recuperarLocalizacaoAtual(completeAddress: true);
                      _movimentarCamera();
                  },
                )
              : Container(
                  alignment: Alignment.center,
                  height: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Esperando conexão com a Internet...",
                      ),
                    ],
                  ),
                ),
          Card(
            //Onde fica o endereço
            margin: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5,
            ),
            elevation: 3.0,
            child: Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _connectivityResult != ConnectivityResult.none &&
                            _finalCurrentUserAddress != ""
                        ? Expanded(
                            child: Text(
                              _finalCurrentUserAddress,
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Row(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(
                                width: 16,
                              ),
                              if (_connectivityResult !=
                                      ConnectivityResult.none &&
                                  _finalCurrentUserAddress == "")
                                Text(
                                  "Carregando o endereço...",
                                ),
                              if (_connectivityResult ==
                                      ConnectivityResult.none &&
                                  _finalCurrentUserAddress != "")
                                Text(
                                  "Esperando conexão com a Internet...",
                                ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            //color: Colors.amberAccent,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Consumer<Lanterna>(
                  builder: (context, lanterna, child) {
                    return FloatingActionButton(
                      onPressed: () => lanterna.toggleFlashMode(),
                      child: Icon(
                        lanterna.isFlashModeOn
                            ? Icons.wb_incandescent
                            : Icons.wb_incandescent_outlined,
                        size: 36,
                      ),
                      heroTag: 'flash',
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                _connectivityResult != ConnectivityResult.none
                    ? FloatingActionButton(
                        onPressed: () {
                          _recuperarLocalizacaoAtual(completeAddress: true);
                          _movimentarCamera();
                        },
                        child: Icon(
                          Icons.gps_fixed,
                          size: 36,
                        ),
                        tooltip: "Atualizar endereço",
                        heroTag: 'maps',
                      )
                    : FloatingActionButton(
                        onPressed: null,
                        child: Icon(
                          Icons.gps_off,
                          size: 36,
                        ),
                        tooltip: "Atualizar endereço",
                        heroTag: 'maps',
                      ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _connectivityResult != ConnectivityResult.none
                    ? TextButton.icon(
                        icon: const Icon(
                          Icons.map,
                          size: 48,
                        ),
                        label: Text('Abrir no Maps'),
                        onPressed: () {
                          _openOnMaps(this.context);
                        })
                    : TextButton.icon(
                        icon: const Icon(
                          Icons.map,
                          size: 48,
                        ),
                        label: Text('Abrir no Maps'),
                        onPressed: null),
                _connectivityResult != ConnectivityResult.none
                    ? TextButton.icon(
                        icon: const Icon(
                          Icons.share,
                          size: 48,
                        ),
                        label: Text('Enviar meu local'),
                        onPressed: () => _onShare(this.context),
                      )
                    : TextButton.icon(
                        icon: const Icon(
                          Icons.share,
                          size: 48,
                        ),
                        label: Text('Enviar meu local'),
                        onPressed: null,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//_TODO 17/09/21_21/09/21: Tratar as mensagens de permissão para acesso ao GPS
//TODO 17/09/21: Tratar quando o GPS estiver desligado: somente LatLng e aviso no mapa
//_18/09/21_TODO 17/09/21: O mapa não está sendo exibido quando volta de outro app
//TODO 17/09/21: (CÓDIGO) Dividir ao máximo que puder os Widgets
//TODO 17/09/21: Refatorar para código limpo
//_TODO 17/09/21_21/09/21: Definir a constante de zoom inicial da câmera
