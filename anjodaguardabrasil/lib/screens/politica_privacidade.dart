import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PoliticaPrivacidade extends StatelessWidget {
  const PoliticaPrivacidade({Key? key}) : super(key: key);
  static const routeName = "/politica_privacidade";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Política de Privacidade"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                children: [
              Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                child:
                  Image.asset(
                    'assets/images/imgEscudoBrasil.png',
                    height: 168,

                  ),
              ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 30, 16, 16),
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text: '',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: '\t\t\tO app Anjo da Guarda ',
                        style: TextStyle(),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // open desired screen
                          }),
                    TextSpan(
                        text:
                            'não armazena quaisquer informações dos usuários sob quaisquer hipóteses.\n\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // open desired screen
                          }),
                    TextSpan(
                        text:
                            '\t\t\tAs seguintes permissões são solicitadas pelo sistema operacional do seu aparelho:\n\n'
                            '\t\t\t\t\t\ta. Acesso ao local: para que você possa enviar sua localização para outra pessoa;\n\n'
                            '\t\t\t\t\t\tb. Acesso à câmera: para que você possa usar a ferramenta de lanterna;\n\n'
                            '\t\t\t\t\t\tc. Realizar chamadas: para que seja possível você ligar para os telefones de emergência;\n\n\n',
                        style: TextStyle(),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // open desired screen
                          }),
                    TextSpan(
                        text:
                            '\t\t\tEste App respeita as políticas de privacidade do Google em todos os seus termos.',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // open desired screen
                          }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
