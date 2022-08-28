import 'package:flutter/material.dart';
import 'package:wine_app/api_service.dart';
import 'package:wine_app/main.dart';
import 'package:wine_app/model/get_bottles.dart';
import 'package:wine_app/widget/bottles.dart';

class BottlesLikedPage extends StatelessWidget {
  const BottlesLikedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const SingleChildScrollView(child: BottlesLikedSection()),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
              backgroundColor: const Color.fromARGB(1, 250, 250, 250),
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

class BottlesLikedSection extends StatefulWidget {
  const BottlesLikedSection({Key? key}) : super(key: key);

  @override
  State<BottlesLikedSection> createState() => BottlesLikedSectionState();
}

class BottlesLikedSectionState extends State<BottlesLikedSection> {
  late Future<Bottles> bottles;

  @override
  void initState() {
    super.initState();
    bottles = ApiService().getBottlesLiked();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
