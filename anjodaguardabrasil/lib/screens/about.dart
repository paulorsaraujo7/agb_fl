import 'package:anjodaguardabrasil/helpers/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  static const routeName = '/about';
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sobre"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30),
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: SizedBox(
                child: Image.asset('assets/images/imgLogoFlagBrazil.png'),
                height: 90,
              ),
              onTap: () => {
                setState(() {
                  Functions.launchInBrowser(
                      "https://www.deftrue.com/privacy_police.php");
                }),
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Anjo da Guarda",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  "®",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "O Brasil pela segurança dos seus cidadãos.",
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const Text("Outubro de 2021"),
            const SizedBox(
              height: 5,
            ),
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text('Version: ${snapshot.data!.version}');
                }
                return Text("");
              },
            ),
            //Text("Version: $_version"),
            const SizedBox(
              height: 60,
            ),
            const Text(
              "Produzido por:",
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              child: SizedBox(
                child: Image.asset('assets/images/imgLogoDefTrue266x77.png'),
                width: 120,
              ),
              onTap: () {
                setState(() {
                  Functions.launchInBrowser("https://www.deftrue.com");
                });
              },
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Colors.grey,
                  ),
                  Text(
                    "Crédito das imagens",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  Functions.launchInBrowser(
                      "https://pngtree.com/freepng/brazil-flag_6521033.html?sol=downref&id=bef");
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

/*
*
            GestureDetector(
              child: const CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(
                  'assets/images/imgLogoDefTrue266x77.png',
                ),
              ),
              onTap: () {
                setState(() {
                  Functions.launchInBrowser("https://www.deftrue.com");
                });
              },
            ),

*
CircleAvatar(
                radius: 20,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text(_listOfInstitutions[index].short),
                  ),
                ),
              ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Paulo Araújo",
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Natal/RN",
            ),

* */
