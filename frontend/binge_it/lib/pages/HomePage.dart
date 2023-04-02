import 'package:binge_it/bin/models.dart';
import 'package:binge_it/pages/MoviePage.dart';
import 'package:flutter/material.dart';

import 'package:binge_it/bin/binge_it_backend.dart';
import '../widgets/CustomNavBar.dart';
import '../widgets/Dropdown.dart';

Future<List<dynamic>> recommendation(String media, MediaType m, int n) async {
  var recommended = await recommend(media, m, n);
  var listOfMedia = recommended.split('|');
  List<dynamic> results = List.empty(growable: true);
  for (var i in listOfMedia) {
    results.add(await findMedia(i, m));
  }
  return results;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var leftsum = 0;
  String abc = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'BingeIt ',
                        style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Want some suggestions ?',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 60,
                      width: 60,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: Color(0xFF292B37),
              ),
              child: const Text(
                "Enter your Recently Watched Movie ",
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 60,
              width: 350,
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.white, border: Border.all(color: Colors.black, width: 4)),
              child: Center(
                child: TextField(
                  onChanged: (String value) {
                    setState(() {
                      abc = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 80,
            ),
            SizedBox(
              height: 150,
            ),
            Container(
              height: 50,
              width: 200,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: Color(0xFF292B37),
              ),
              child: InkWell(
                onTap: () async {
                  List<dynamic> recommendationBook = await recommendation(abc, MediaType.book, 5);
                  List<dynamic> recommendationMovie = await recommendation(abc, MediaType.movie, 5);
                  List<dynamic> recommendationTV = await recommendation(abc, MediaType.tv, 5);
                  Navigator.pushNamed(context, "moviePage");
                },
                child: Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
