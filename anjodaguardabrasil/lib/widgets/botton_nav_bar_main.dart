import 'package:anjodaguardabrasil/helpers/lanterna.dart';
import 'package:anjodaguardabrasil/screens/user_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AGB_BottomNavBarMain extends StatelessWidget {
  const AGB_BottomNavBarMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 6,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                icon: const Icon(
                  Icons.gps_fixed,
                  size: 48,
                ),
                label: Text('Onde estou'),
                onPressed: () =>
                    Navigator.of(context).pushNamed(MyLocation.routeName),
              ),
              Consumer<Lanterna>(
                builder: (context, lanterna, child) {
                  return               TextButton.icon(
                    icon: Icon(
                      lanterna.isFlashModeOn
                          ? Icons.wb_incandescent
                          : Icons.wb_incandescent_outlined,
                      size: 48,
                    ),
                    label: lanterna.isFlashModeOn
                        ? Text('Desligar Lanterna')
                        : Text('Ligar Lanterna'),
                    onPressed: () => lanterna.toggleFlashMode(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
