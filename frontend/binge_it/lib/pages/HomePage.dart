import 'package:binge_it/bin/models.dart';
import 'package:binge_it/pages/MoviePage.dart';
import 'package:flutter/material.dart';

import 'package:binge_it/bin/binge_it_backend.dart';
import '../widgets/CustomNavBar.dart';
import '../widgets/Dropdown.dart';

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
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w500),
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
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 60,
              width: 350,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 4)),
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
                onTap: () {
                  await recommendation();
                  Navigator.pushNamed(context, "moviePage");
                },
                child: Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Future<void> recommendation() async {
    var recommendedTv = await recommend(abc, MediaType.tv, 5);
  }
}
