import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wine_app/api_service.dart';
import 'package:wine_app/main.dart';
import 'package:wine_app/model/get_bottle.dart';
import 'package:wine_app/model/get_bottles.dart';
import 'package:wine_app/widget/cellars.dart';

class BottlePage extends StatelessWidget {
  final int bottleId;
  const BottlePage({Key? key, required this.bottleId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BottleSection(
          bottleId: bottleId,
        ),
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
                      MaterialPageRoute(builder: (_) => const HomePage()));
                },
              )),
        ));
  }
}

class BottleSection extends StatefulWidget {
  final int bottleId;
  const BottleSection({Key? key, required this.bottleId}) : super(key: key);

  @override
  State<BottleSection> createState() => BottleSectionState();
}

class BottleSectionState extends State<BottleSection> {
  late Future<Bottle> bottle;
  @override
  void initState() {
    super.initState();
    bottle = ApiService().getBottle(widget.bottleId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: const Color.fromARGB(1, 250, 250, 250),
      child: Column(
        children: [
          Column(children: [
            FutureBuilder<Bottle>(
              future: bottle,
              builder: (context, snapshot) {
                List<Widget> children = [];
                if (snapshot.hasData) {
                  return Column(children: children);
                }
                return Container(
                    alignment: Alignment.center,
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
