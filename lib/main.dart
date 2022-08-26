import 'package:flutter/material.dart';
import 'package:wine_app/widget/bottles.dart';
import 'package:wine_app/widget/bottles_liked.dart';
import 'package:wine_app/widget/cellars.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wine Cellar',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(),
        body: SingleChildScrollView(
          child: Container(
              color: const Color.fromARGB(1, 250, 250, 250),
              child: Column(
                children: const [
                  SearchSection(),
                  BottlesSection(),
                ],
              )),
        ));
  }
}

class SearchSection extends StatelessWidget {
  const SearchSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Saint-Emilion Grand Cru',
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    shape: const CircleBorder(),
                    shadowColor: Colors.white,
                    primary: Colors.redAccent,
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: [
        IconButton(
            icon: Icon(
              Icons.favorite_outline_rounded,
              color: Colors.grey[800],
              size: 20,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const BottlesLikedPage()));
            }),
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CellarsPage()));
            },
            icon: Icon(
              Icons.app_registration_rounded,
              color: Colors.grey[800],
              size: 20,
            ))
      ],
    );
  }
}
