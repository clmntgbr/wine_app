import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wine_app/api_service.dart';
import 'package:wine_app/main.dart';
import 'package:wine_app/model/get_cellars.dart';

class CellarsPage extends StatelessWidget {
  const CellarsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              )),
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
      color: Colors.white,
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
                        backgroundColor: Colors.redAccent,
                      ),
                    ));
              },
            )
          ]),
        ],
      ),
    );
  }
}

class CellarsCard extends StatelessWidget {
  final HydraMember cellar;

  const CellarsCard({Key? key, required this.cellar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color cellarColor = Colors.grey.shade200;
    if (cellar.isActive) {
      cellarColor = Colors.greenAccent;
    }

    return Container(
        padding: const EdgeInsets.all(10),
        child: MaterialButton(
            onPressed: () {},
            padding: const EdgeInsets.all(0),
            child: Container(
              margin: const EdgeInsets.all(0),
              height: 90,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ),
                border: Border.all(color: cellarColor, width: 2),
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
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Grand Royl Hotel',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          '400e',
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
                          'wembley, London',
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.place,
                              size: 14.0,
                            ),
                            Text(
                              '2 km to city',
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'per night',
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 3, 10, 0),
                    child: Row(
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.star_rate,
                              size: 14.0,
                            ),
                            Icon(
                              Icons.star_rate,
                              size: 14.0,
                            ),
                            Icon(
                              Icons.star_rate,
                              size: 14.0,
                            ),
                            Icon(
                              Icons.star_rate,
                              size: 14.0,
                            ),
                            Icon(
                              Icons.star_border,
                              size: 14.0,
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Text(
                          '42 reviews',
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
