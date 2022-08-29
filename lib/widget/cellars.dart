import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wine_app/api_service.dart';
import 'package:wine_app/globals.dart' as globals;
import 'package:wine_app/main.dart';
import 'package:wine_app/model/get_cellars.dart';
import 'package:wine_app/widget/cellar.dart';

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
                      Text(globals.splitString(cellar.name, 25),
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
