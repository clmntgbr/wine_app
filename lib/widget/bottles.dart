import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wine_app/api_service.dart';
import 'package:wine_app/model/get_bottles.dart';

class BottlesSection extends StatefulWidget {
  const BottlesSection({super.key});

  @override
  State<BottlesSection> createState() => BottlesSectionState();
}

class BottlesSectionState extends State<BottlesSection> {
  late Future<Bottles> bottles;

  @override
  void initState() {
    super.initState();
    bottles = ApiService().getBottles();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: const Color.fromARGB(1, 250, 250, 250),
      child: Column(
        children: [
          Column(children: [
            FutureBuilder<Bottles>(
              future: bottles,
              builder: (context, snapshot) {
                List<Widget> children = [];
                if (snapshot.hasData) {
                  children
                      .add(BottlesFilter(length: snapshot.data!.totalItems));
                  for (HydraMember bottle in snapshot.data!.hydraMember) {
                    children.add(BottlesCard(bottle: bottle));
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
      ),
    );
  }
}

class BottlesFilter extends StatelessWidget {
  const BottlesFilter({Key? key, required this.length}) : super(key: key);

  final int length;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$length bouteille(s) trouvée(s)',
            style: GoogleFonts.nunito(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          Row(
            children: [
              Text(
                'Filtres',
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              const IconButton(
                icon: Icon(
                  Icons.filter_list_outlined,
                  size: 25,
                ),
                onPressed: null,
              )
            ],
          )
        ],
      ),
    );
  }
}

class BottlesCard extends StatefulWidget {
  final HydraMember bottle;

  const BottlesCard({Key? key, required this.bottle}) : super(key: key);

  @override
  State<BottlesCard> createState() => BottlesCardState();
}

class BottlesCardState extends State<BottlesCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HydraMember bottle = widget.bottle;

    Color buttonColor = Colors.white;
    if (bottle.isLiked) {
      buttonColor = Colors.greenAccent;
    }

    return Container(
      margin: const EdgeInsets.all(10),
      height: 230,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(18),
        ),
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
            height: 140,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/hotel_1.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 5,
                  right: -15,
                  child: MaterialButton(
                    color: buttonColor,
                    shape: const CircleBorder(),
                    onPressed: () {
                      ApiService().putBottlesLiked(bottle.id, !bottle.isLiked);
                      bottle.isLiked = !bottle.isLiked;
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.favorite_outline_rounded,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'id: ${bottle.id}',
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
    );
  }
}
