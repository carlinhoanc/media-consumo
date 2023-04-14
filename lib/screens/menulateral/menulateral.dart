import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediaconsumo/screens/dashborad/dashborad.dart';
import 'package:mediaconsumo/screens/manutencao/manutencao_add.dart';
import 'package:mediaconsumo/screens/manutencao/manutencao_lista.dart';
import 'package:mediaconsumo/screens/media/media_add.dart';
import 'package:mediaconsumo/screens/media/media_lista.dart';
import 'package:mediaconsumo/screens/posto/posto_add.dart';
import 'package:mediaconsumo/screens/posto/posto_lista.dart';
import 'package:mediaconsumo/screens/veiculo/veiculo_add.dart';
import 'package:mediaconsumo/screens/veiculo/veiculo_lista.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              'Manutenção, Médias',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
              ),
            ),
          ),
          menu(Icons.home, context, "Inicio" , Dashboard()),

          menu(Icons.calculate_outlined, context, "Medias" , MediaList()),
          // menu(Icons.add_box, context, "Add Medias" , MediaAdd()),

          menu(Icons.drive_eta, context, "Veiculos", VeiculoList()),
          // menu(Icons.add_circle, context, "Add Veiculos", VeiculoAdd()),

          menu(Icons.local_gas_station, context, "Postos", PostoList()),
          // menu(Icons.add_location_outlined, context, "Add Postos", PostoAdd()),

          menu(Icons.handyman, context, "Manutenções", ManutencaoList()),
          // menu(Icons.alarm_add, context, "Add Manutenções", ManutencaoAdd()),
        ],
      ),
    );
  }

  ListTile menu(IconData icon, BuildContext context, String nomeMenu , router) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        nomeMenu,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => router,
          ),
        );
      },
    );
  }
}
