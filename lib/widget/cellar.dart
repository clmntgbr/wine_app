import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wine_app/api_service.dart';
import 'package:wine_app/widget/cellars.dart';

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
                  Navigator.pop(context);
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
                          ApiService()
                              .postCellar(
                                  nameController.text.toString(),
                                  _currentSliderColumnValue.round(),
                                  _currentSliderRowValue.round())
                              .then((value) {
                            if (value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const CellarsPage()));
                            } else {
                              isCallApi = true;
                              setState(() {
                                createButton = const Text('Créer');
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Nous sommes désolés, une erreur s\'est produite. Veuillez enregistrer vos modifications de nouveau.',
                                      textAlign: TextAlign.center),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }
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
                  Navigator.pop(context);
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

  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  double _currentSliderRowValue = 10;
  double _currentSliderColumnValue = 10;
  bool isInit = false;
  TextEditingController nameController = TextEditingController();

  Widget updateButton = const Text('Modifier');
  Widget deleteButton =
      const Text('Supprimer', style: TextStyle(color: Colors.redAccent));

  @override
  Widget build(BuildContext context) {
    int cellarId = widget.id;

    if (!isInit) {
      _currentSliderRowValue = widget.rowSliderValue.toDouble();
      _currentSliderColumnValue = widget.columnSliderValue.toDouble();
      nameController = TextEditingController(text: widget.name);
    }

    if (isInit) {
      nameController = nameController;
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
                        isInit = true;
                        setState(() {
                          updateButton = const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          );
                          ApiService()
                              .putCellar(
                                  cellarId,
                                  nameController.text.toString(),
                                  _currentSliderColumnValue.round(),
                                  _currentSliderRowValue.round())
                              .then((value) {
                            if (value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const CellarsPage()));
                            } else {
                              isCallApi = true;
                              setState(() {
                                updateButton = const Text('Modifier');
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Nous sommes désolés, une erreur s\'est produite. Veuillez enregistrer vos modifications de nouveau.',
                                      textAlign: TextAlign.center),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }
                          });
                        });
                      }
                    },
                    child: updateButton,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.white,
                      side: const BorderSide(width: 1, color: Colors.red),
                      primary: Colors.white,
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    onPressed: () {
                      if (isCallApi && formKey.currentState!.validate()) {
                        isCallApi = false;
                        isInit = true;
                        setState(() {
                          deleteButton = const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.redAccent),
                          );
                          ApiService().deleteCellar(cellarId).then((value) {
                            if (value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const CellarsPage()));
                            } else {
                              isCallApi = true;
                              setState(() {
                                deleteButton = const Text('Supprimer',
                                    style: TextStyle(color: Colors.redAccent));
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Nous sommes désolés, une erreur s\'est produite. Veuillez enregistrer vos modifications de nouveau.',
                                      textAlign: TextAlign.center),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }
                          });
                        });
                      }
                    },
                    child: deleteButton,
                  ),
                )
              ]))
        ])));
  }
}
