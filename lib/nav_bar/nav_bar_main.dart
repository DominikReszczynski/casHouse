import 'package:flutter/material.dart';

class NavBarMain extends StatefulWidget {
  const NavBarMain({super.key});

  @override
  State<NavBarMain> createState() => _NavBarMainState();
}

class _NavBarMainState extends State<NavBarMain> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(children: [
      Column(
        children: [
          Container(
            height: 20,
            width: double.maxFinite,
            decoration: BoxDecoration(color: Colors.pink),
          ),
          Container(
              height: 60,
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(color: Colors.red),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(color: Colors.transparent),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(color: Colors.green),
                  )
                ],
              )),
        ],
      ),
      Positioned(
          top: 0,
          left: screenWidth / 2 - 40,
          width: 70,
          height: 70,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(100)))),
    ]
        // Text("Navbar"),
        );
  }
}
