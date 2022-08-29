import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wine_app/api_service.dart';
import 'package:wine_app/main.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [Text('${widget.bottleId}')])));
  }
}
