import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wine_app/api_service.dart';
import 'package:wine_app/globals.dart' as globals;
import 'package:wine_app/main.dart';
import 'package:wine_app/model/get_cellars.dart';
import 'dart:io';

class CellarsPage extends StatelessWidget {
  const CellarsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    globals.cellarActiveId = 0;

    return Scaffold(
        body: const CellarsSection(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
              title: Text(
                'Caves à vins',
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const HomePage()));
                },
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CreateCellarPage()));
                    },
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: Colors.grey[800],
                      size: 20,
                    ))
              ]),
        ));
  }
}

class CreateCellarPage extends StatelessWidget {
  const CreateCellarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const CreateCellarSection(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const CellarsPage()));
                },
              )),
        ));
  }
}

class CreateCellarSection extends StatefulWidget {
  const CreateCellarSection({Key? key}) : super(key: key);

  @override
  State<CreateCellarSection> createState() => CreateCellarSectionState();
}

class CreateCellarSectionState extends State<CreateCellarSection> {
  bool isCallApi = true;
  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  double _currentSliderRowValue = 10;
  double _currentSliderColumnValue = 10;

  Widget createButton = const Text('Créer');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          Form(
              key: formKey,
              child: Column(children: [
                Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 50),
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir un nom pour votre cave à vin';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Cave à vin Perso'),
                    )),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nombres de lignes : ${_currentSliderRowValue.round()}',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite - 100,
                          child: CupertinoSlider(
                            activeColor: Colors.redAccent,
                            value: _currentSliderRowValue,
                            max: 100,
                            divisions: 100,
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderRowValue = value;
                              });
                            },
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nombres de Colonnes : ${_currentSliderColumnValue.round()}',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite - 100,
                          child: CupertinoSlider(
                            activeColor: Colors.redAccent,
                            value: _currentSliderColumnValue,
                            max: 100,
                            divisions: 100,
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderColumnValue = value;
                              });
                            },
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    onPressed: () {
                      if (isCallApi && formKey.currentState!.validate()) {
                        isCallApi = false;
                        setState(() {
                          createButton = const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          );
                          ApiService().postCellar(
                              nameController.text.toString(),
                              _currentSliderColumnValue.round(),
                              _currentSliderRowValue.round());
                          Future.delayed(const Duration(seconds: 6)).then((_) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CellarsPage()));
                          });
                        });
                      }
                    },
                    child: createButton,
                  ),
                )
              ]))
        ])));
  }
}

class UpdateCellarPage extends StatelessWidget {
  final int id;
  final String name;
  final int rowSliderValue;
  final int columnSliderValue;

  const UpdateCellarPage(
      {Key? key,
      required this.id,
      required this.name,
      required this.rowSliderValue,
      required this.columnSliderValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: UpdateCellarSection(
            name: name,
            id: id,
            rowSliderValue: rowSliderValue,
            columnSliderValue: columnSliderValue),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const CellarsPage()));
                },
              )),
        ));
  }
}

class UpdateCellarSection extends StatefulWidget {
  final int id;
  final String name;
  final int rowSliderValue;
  final int columnSliderValue;

  const UpdateCellarSection(
      {Key? key,
      required this.id,
      required this.name,
      required this.rowSliderValue,
      required this.columnSliderValue})
      : super(key: key);

  @override
  State<UpdateCellarSection> createState() => UpdateCellarSectionState();
}

class UpdateCellarSectionState extends State<UpdateCellarSection> {
  bool isCallApi = true;
  bool isInit = false;
  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  double _currentSliderRowValue = 10;
  double _currentSliderColumnValue = 10;
  TextEditingController nameController = TextEditingController();

  Widget updateButton = const Text('Modifier');

  @override
  Widget build(BuildContext context) {
    int cellarId = widget.id;

    if (!isInit) {
      _currentSliderRowValue = widget.rowSliderValue.toDouble();
      _currentSliderColumnValue = widget.columnSliderValue.toDouble();
      nameController = TextEditingController(text: widget.name);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          Form(
              key: formKey,
              child: Column(children: [
                Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 50),
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir un nom pour votre cave à vin';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Cave à vin Perso'),
                    )),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nombres de lignes : ${_currentSliderRowValue.round()}',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite - 100,
                          child: CupertinoSlider(
                            activeColor: Colors.redAccent,
                            value: _currentSliderRowValue,
                            max: 100,
                            divisions: 100,
                            onChanged: (double value) {
                              setState(() {
                                isInit = true;
                                _currentSliderRowValue = value;
                              });
                            },
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nombres de Colonnes : ${_currentSliderColumnValue.round()}',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite - 100,
                          child: CupertinoSlider(
                            activeColor: Colors.redAccent,
                            value: _currentSliderColumnValue,
                            max: 100,
                            divisions: 100,
                            onChanged: (double value) {
                              setState(() {
                                isInit = true;
                                _currentSliderColumnValue = value;
                              });
                            },
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    onPressed: () {
                      if (isCallApi && formKey.currentState!.validate()) {
                        isCallApi = false;
                        setState(() {
                          updateButton = const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          );
                          ApiService().putCellar(
                              cellarId,
                              nameController.text.toString(),
                              _currentSliderColumnValue.round(),
                              _currentSliderRowValue.round());
                          Future.delayed(const Duration(seconds: 6)).then((_) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CellarsPage()));
                          });
                        });
                      }
                    },
                    child: updateButton,
                  ),
                )
              ]))
        ])));
  }
}

class CellarsSection extends StatefulWidget {
  const CellarsSection({Key? key}) : super(key: key);

  @override
  State<CellarsSection> createState() => CellarsSectionState();
}

class CellarsSectionState extends State<CellarsSection> {
  late Future<Cellars> cellars;

  @override
  void initState() {
    super.initState();
    cellars = ApiService().getCellars();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Column(children: [
              FutureBuilder<Cellars>(
                future: cellars,
                builder: (context, snapshot) {
                  List<Widget> children = [];
                  if (snapshot.hasData) {
                    for (HydraMember cellar in snapshot.data!.hydraMember) {
                      children.add(CellarsCard(cellar: cellar));
                    }
                    return Column(children: children);
                  }
                  return Container(
                      padding: const EdgeInsets.all(50),
                      child: const SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.redAccent),
                        ),
                      ));
                },
              )
            ]),
          ],
        )));
  }
}

class CellarsCard extends StatefulWidget {
  final HydraMember cellar;

  const CellarsCard({Key? key, required this.cellar}) : super(key: key);

  @override
  State<CellarsCard> createState() => CellarsCardState();
}

class CellarsCardState extends State<CellarsCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HydraMember cellar = widget.cellar;
    Color cellarColor = Colors.grey.shade200;

    if (cellar.isActive) {
      cellarColor = Colors.green;
    }

    return Container(
        padding: const EdgeInsets.all(10),
        child: MaterialButton(
            onPressed: () async {
              if (!cellar.isActive) {
                ApiService().putCellarsActive(cellar.id, true);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const HomePage()));
              }
            },
            padding: const EdgeInsets.all(0),
            child: Container(
              margin: const EdgeInsets.all(0),
              height: 110,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ),
                border: Border.all(color: cellarColor, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 4,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 50,
                          child: MaterialButton(
                            shape: const CircleBorder(),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => UpdateCellarPage(
                                          id: cellar.id,
                                          name: cellar.name,
                                          rowSliderValue: cellar.row,
                                          columnSliderValue: cellar.column)));
                            },
                            child: const Icon(
                              Icons.mode_edit,
                              color: Colors.grey,
                              size: 20,
                            ),
                          )),
                      Text(globals.splitString(cellar.name),
                          maxLines: 1,
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ))
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lignes: ${cellar.row} - Colonnes: ${cellar.column}',
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '${cellar.bottlesInCellar}',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Place(s) restante(s): ${(cellar.row * cellar.column) - cellar.bottlesInCellar}',
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'bouteilles',
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
