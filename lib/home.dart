import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/comp/CustomAppBar.dart';
import 'package:tic_tac_toe_app/comp/CustomButton.dart';
import 'package:tic_tac_toe_app/theme/AppTheme.dart';
import 'package:tic_tac_toe_app/alert_dialog.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controllerJugador1 = new TextEditingController();
  late TextEditingController _controllerJugador2 = new TextEditingController();
  List labelList = [" ", " ", " ", " ", " ", " ", " ", " ", " "];
  bool enableDisable = false;
  String turno = "";
  String ganador = "";
  bool clickTurno = false;
  int chance_flag = 0;
  int filledBox = 0;

  void accion() {
    setState(() {
      AppTheme.colorX = Colors.blue;
    });
  }

  void btnInicio() {
    labelList.replaceRange(0, 9, ["", "", "", "", "", "", "", "", ""]);
    ganador = "";
    enableDisable = true;
    chance_flag = 0;
    Random rnd = new Random();
    int min = 13, max = 42;
    int r = min + rnd.nextInt(max - min);
    if (r % 2 == 0) {
      turno = "P1:${_controllerJugador1.value.text}-(X)";
    } else {
      turno = "P2:${_controllerJugador2.value.text}-(O)";
    }
  }

  void btnAnular() {
    labelList.replaceRange(0, 9, ["", "", "", "", "", "", "", "", ""]);
    enableDisable = false;
    turno = "";
  }

  void numClick(String text, int index) {
    setState(() {
      if (text == "") {
        chance_flag += 1;
      }
      start(index);
      matchCheck();
      print(
          "ver txt: ${text} index: ${index} num val: ${labelList[index]} cant:${chance_flag}");
    });
  }

  void start(int index) {
    var parts = turno.split(':');
    if (parts[0].trim() == "P1" && clickTurno == false) {
      labelList[index] = "X";
      clickTurno = true;
      turno = "P2:${_controllerJugador2.value.text}-(O)";
    } else {
      labelList[index] = "O";
      clickTurno = false;
      turno = "P1:${_controllerJugador1.value.text}-(X)";
    }
  }

  void matchCheck() {
    if ((labelList[0] == "X") &&
        (labelList[1] == "X") &&
        (labelList[2] == "X")) {
      xWins();
    } else if ((labelList[0] == "X") &&
        (labelList[4] == "X") &&
        (labelList[8] == "X")) {
      xWins();
    } else if ((labelList[0] == "X") &&
        (labelList[3] == "X") &&
        (labelList[6] == "X")) {
      xWins();
    } else if ((labelList[1] == "X") &&
        (labelList[4] == "X") &&
        (labelList[7] == "X")) {
      xWins();
    } else if ((labelList[2] == "X") &&
        (labelList[4] == "X") &&
        (labelList[6] == "X")) {
      xWins();
    } else if ((labelList[2] == "X") &&
        (labelList[5] == "X") &&
        (labelList[8] == "X")) {
      xWins();
    } else if ((labelList[3] == "X") &&
        (labelList[4] == "X") &&
        (labelList[5] == "X")) {
      xWins();
    } else if ((labelList[6] == "X") &&
        (labelList[7] == "X") &&
        (labelList[8] == "X")) {
      xWins();
    } else if ((labelList[0] == "O") &&
        (labelList[1] == "O") &&
        (labelList[2] == "O")) {
      oWins();
    } else if ((labelList[0] == "O") &&
        (labelList[3] == "O") &&
        (labelList[6] == "O")) {
      oWins();
    } else if ((labelList[0] == "O") &&
        (labelList[4] == "O") &&
        (labelList[8] == "O")) {
      oWins();
    } else if ((labelList[1] == "O") &&
        (labelList[4] == "O") &&
        (labelList[7] == "O")) {
      oWins();
    } else if ((labelList[2] == "O") &&
        (labelList[4] == "O") &&
        (labelList[6] == "O")) {
      oWins();
    } else if ((labelList[2] == "O") &&
        (labelList[5] == "O") &&
        (labelList[8] == "O")) {
      oWins();
    } else if ((labelList[3] == "O") &&
        (labelList[4] == "O") &&
        (labelList[5] == "O")) {
      oWins();
    } else if ((labelList[6] == "O") &&
        (labelList[7] == "O") &&
        (labelList[8] == "O")) {
      oWins();
    } else if (chance_flag == 9) {
      enableDisable = false;
      ganador = "Empate";
      turno = "Termino";
    }
  }

  void xWins() {
    ganador = "${_controllerJugador1.value.text}-(X)";
    enableDisable = false;
    turno = "Termino"; //if(chance_flag==9){ turno="Termino";}
  }

  void oWins() {
    ganador = "${_controllerJugador2.value.text}-(O)";
    enableDisable = false;
    turno = "Termino"; //if(chance_flag==9){ turno="Termino";}
  }

  void _showAlert(String title, String winner) {
    showAlert(
        context: context,
        title: title,
        message: winner == ''
            ? 'La partida fue empate'
            : 'El ganador es ${winner.toUpperCase()}',
        buttonText: 'OK',
        onPressed: () {
          clearBoard();
          Navigator.of(context).pop();
        });
  }

  void clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        labelList[i] = '';
      }
    });

    filledBox = 0;
  }

  @override
  Widget build(BuildContext context) {
    AppTheme.colorX = Colors.blue;
    List funx = [
      numClick,
      numClick,
      numClick,
      numClick,
      numClick,
      numClick,
      numClick,
      numClick,
      numClick
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.themeData, //Fin Agregado
      home: Scaffold(
          appBar: CustomAppBar(accionx: accion as Function),
          //appBar: AppBar(title: Text("Holas")),
          body: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Tic Tac Toe',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'fantasy',
                    ),
                  ),
                  _buidForm(),
                  GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                    children: [
                      ...List.generate(
                        labelList.length,
                        (indexx) => CustomButton(
                          text: labelList[indexx],
                          index: indexx,
                          buttonenabled: enableDisable,
                          callback: funx[indexx] as Function,
                        ),
                      ),
                    ],
                    padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                  ),
                  SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Chip(
                          avatar: CircleAvatar(
                            backgroundColor: Colors.grey.shade800,
                            child: const Text(
                              'Turno:',
                              style: TextStyle(fontSize: 7.0),
                            ),
                          ),
                          label: Text(turno)),
                      Chip(
                          avatar: CircleAvatar(
                            backgroundColor: Colors.grey.shade900,
                            child: const Text(
                              'Ganador:',
                              style: TextStyle(fontSize: 5.0),
                            ),
                          ),
                          label: Text(ganador))
                    ],
                  ),
                ],
              ))),
    );
  }

  Form _buidForm() {
    return Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre Jugador 1:',
                  ),
                  controller: _controllerJugador1,
                ),
                SizedBox(height: 6),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre Jugador 2:',
                  ),
                  controller: _controllerJugador2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            btnInicio();
                          });
                        },
                        child: Text("Iniciar")),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            btnAnular();
                          });
                        },
                        child: Text("Anular")),
                  ],
                )
              ],
            )));
  }
}
