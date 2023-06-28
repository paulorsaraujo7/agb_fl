import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Functions {

  static Future<void> onShareLinkApp(BuildContext context) async {
    var url = "https://play.google.com/store/apps/details?id=com.idyoou.anjodaguardabrasil";
    url = Uri.parse(url).toString();
    var subject_indicar_app =
        "Confira o aplicativo \"Anjo da Guarda\" para Android";
    var texto_indicar_app =
        "Principais Telefones de EMERGÊNCIA do Brasil e sua LOCALIZAÇÃO no mapa em um toque. "
        "\n\nNum só App você tem telefones de utilidade pública; ferramenta de "
        "lanterna; envio de sua localização via internet ou SMS e lista com links para os aplicativos do Governo Federal do Brasil.\n\n"
        "Novas funções em andamento! \n\n"
        "$url";

    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
        texto_indicar_app,
        subject: subject_indicar_app,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    return Future.value(null);
  }

  static Future<void> launchInBrowser(String url) async {
    url = Uri.parse(url).toString();
    try {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } catch (e) {
      print(e.toString());
    }
  }
}