import 'package:anjodaguardabrasil/models/institution.dart';
import 'package:flutter/material.dart';

class DrawerMenuItem extends StatelessWidget {
  const DrawerMenuItem(
      {Key? key,
      required this.title,
      required this.voidCallback,
      required this.institutionType})
      : super(key: key);

  final String title;
  final Function voidCallback;
  final InstitutionType institutionType;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: institutionType == InstitutionType.emergence
          ? (const Icon(
              Icons.local_hospital,
              color: Colors.red,
            ))
          : institutionType == InstitutionType.other_services
              ? (const Icon(
                  Icons.volunteer_activism,
                  color: Colors.amber,
                ))
              : (const Icon(
                  Icons.apps,
                  color: Colors.blue,
                )),
      onTap: () =>
          voidCallback(institutionType), //Navigator.of(context).push(),
    );
  }
}
