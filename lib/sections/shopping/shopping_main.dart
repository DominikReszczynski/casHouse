import 'package:auto_size_text/auto_size_text.dart';
import 'package:cas_house/providers/shopping_provider.dart';
import 'package:cas_house/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ShoppingMain extends StatefulWidget {
  const ShoppingMain({super.key});

  @override
  State<ShoppingMain> createState() => _ShoppingMainState();
}

class _ShoppingMainState extends State<ShoppingMain> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingProvider>(
        builder: (context, shoppingProvider, child) {
      return ListView(
        children: [
          SectionTitle(
              title: "SHOPPING LIST", icon: MdiIcons.plus, onPress: () {}),
        ],
      );
    });
  }
}
