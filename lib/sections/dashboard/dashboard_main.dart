import 'package:auto_size_text/auto_size_text.dart';
import 'package:cas_house/BLoC/dashboard/dashboard_bloc.dart';
import 'package:cas_house/BLoC/dashboard/dashboard_event.dart';
import 'package:cas_house/BLoC/dashboard/dashboard_state.dart';
import 'package:cas_house/sections/dashboard/dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSectionMain extends StatefulWidget {
  const HomeSectionMain({super.key});

  @override
  State<HomeSectionMain> createState() => _HomeSectionMainState();
}

class _HomeSectionMainState extends State<HomeSectionMain> {
  List<Map<String, dynamic>> widgetContent = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBloc(),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<DashboardBloc>(context);

          int count = 0;
          if (state is DashboardInitial) {
            count = state.count;
          }

          return ListView(
            shrinkWrap: true,
            children: [
              const AutoSizeText(
                "Hi, Dominik",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
              ),
              const Divider(),
              Center(
                child: Text(
                  "Dashboard $count",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              IconButton(
                onPressed: () {
                  bloc.add(IncrementEvent());
                },
                icon: const Icon(Icons.plus_one),
              ),
              IconButton(
                onPressed: () {
                  bloc.add(DecrementEvent());
                },
                icon: const Icon(Icons.exposure_minus_1_outlined),
              ),
              for (Map data in widgetContent)
                HomeWidget(
                  icon: data['icon'],
                  openFunction: data['openFunction'],
                  child: data['child'],
                ),
            ],
          );
        },
      ),
    );
  }
}
