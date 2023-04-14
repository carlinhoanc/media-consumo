import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediaconsumo/screens/manutencao/manutencao_lista.dart';
import 'package:mediaconsumo/screens/media/media_lista.dart';
import 'package:mediaconsumo/screens/menulateral/menulateral.dart';
import 'package:mediaconsumo/screens/posto/posto_lista.dart';
import 'package:mediaconsumo/screens/veiculo/veiculo_lista.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Daskboard'),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 1, 4, 4),
            child: Material(
              color: Theme.of(context).primaryColor,
              child: AnalogClock(
                showAllNumbers: true,
                digitalClockColor: Colors.white,
                hourHandColor: Colors.white,
                minuteHandColor: Colors.white,
                numberColor: Colors.white,
                secondHandColor: Colors.white,
                tickColor: Colors.white,
              ),
            ),
          ),
          container(Icons.calculate_outlined, context, "Medias", MediaList()),
          // container(Icons.add_box, context, "Add Medias", MediaAdd()),
          container(Icons.drive_eta, context, "Veiculos", VeiculoList()),
          // container(Icons.add_circle, context, "Add Veiculos", VeiculoAdd()),
          container(Icons.local_gas_station, context, "Postos", PostoList()),
          // container(Icons.add_location_outlined, context, "Add Postos", PostoAdd()),
          container(Icons.handyman, context, "Manutenções", ManutencaoList()),
          // container(Icons.alarm_add, context, "Add Manutenções", ManutencaoAdd()),
        ],
      ),
      drawer: MenuLateral(),
    );
  }

  Padding container(
      IconData icon, BuildContext context, String titulo, router) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 1, 4, 4),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => router,
              ),
            );
          },
          child: Container(
            height: 100,
            width: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 60,
                  ),
                  Text(
                    titulo,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
