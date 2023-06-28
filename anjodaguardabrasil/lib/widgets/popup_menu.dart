import 'package:anjodaguardabrasil/screens/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:anjodaguardabrasil/helpers/functions.dart';

class PopupMenu extends StatefulWidget {
  const PopupMenu({Key? key}) : super(key: key);
  @override
  _PopupMenuState createState() => _PopupMenuState();
}

enum PopupMenuItems { RECOMENDAR_APP, SOBRE, SAIR }

class _PopupMenuState extends State<PopupMenu> {
  PopupMenuItems? _popupMenuItemsSelection;
  Future<void> _onSelectMenuItem(PopupMenuItems result) async {
    setState(() {
      _popupMenuItemsSelection = result;
    });

    if (_popupMenuItemsSelection == PopupMenuItems.SOBRE) {
      Navigator.of(context).pushNamed(About.routeName);
    }

    if (_popupMenuItemsSelection == PopupMenuItems.SAIR) {
      SystemNavigator.pop();
    }

    if (_popupMenuItemsSelection == PopupMenuItems.RECOMENDAR_APP) {
      await Functions.onShareLinkApp(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopupMenuItems>(
      onSelected: (PopupMenuItems result) => _onSelectMenuItem(result),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<PopupMenuItems>>[
        PopupMenuItem<PopupMenuItems>(
          value: PopupMenuItems.RECOMENDAR_APP,
          child: TextButton.icon(
            label: const Text('Recomendar este app'),
            icon: const Icon(Icons.share),
            onPressed: () => _onSelectMenuItem(PopupMenuItems.RECOMENDAR_APP),
          ),
        ),
        PopupMenuItem<PopupMenuItems>(
          value: PopupMenuItems.SOBRE,
          child: TextButton.icon(
            label: const Text('Sobre'),
            icon: const Icon(Icons.announcement),
            onPressed: () => _onSelectMenuItem(PopupMenuItems.SOBRE),
          ),
        ),
        PopupMenuItem<PopupMenuItems>(
          value: PopupMenuItems.SAIR,
          child: TextButton.icon(
              label: const Text('Sair'),
              icon: const Icon(Icons.exit_to_app),
              onPressed: () => _onSelectMenuItem(PopupMenuItems.SAIR)),
        ),
      ],
    );
  }
}
