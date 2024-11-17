import 'package:cas_house/main_global.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavBarMain extends StatefulWidget {
  final Function(Sections) selectedSection;
  const NavBarMain({
    super.key,
    required this.selectedSection,
  });

  @override
  State<NavBarMain> createState() => _NavBarMainState();
}

class _NavBarMainState extends State<NavBarMain> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            Container(
              height: 50,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey, width: 1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => widget.selectedSection(Sections.Dashboard),
                    child: Icon(
                      MdiIcons.cashMultiple,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () => widget.selectedSection(Sections.Shopping),
                    child: Icon(
                      MdiIcons.cart,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () => widget.selectedSection(Sections.Family),
                    child: Icon(
                      MdiIcons.humanMaleFemaleChild,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () => widget.selectedSection(Sections.User),
                    child: Icon(
                      MdiIcons.account,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -25,
          left: MediaQuery.of(context).size.width / 2 - 35,
          width: 70,
          height: 70,
          child: InkWell(
            onTap: () => widget.selectedSection(Sections.Home),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.yellow, spreadRadius: 3, blurRadius: 8),
                ],
              ),
              child: Icon(MdiIcons.home, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
