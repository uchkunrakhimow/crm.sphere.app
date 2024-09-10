import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tedbook/pages/home/bloc/home_bloc.dart';
import 'package:tedbook/persistance/text_style_const.dart';
import 'package:tedbook/utils/color_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late HomeBloc bloc;
  late TabController _tabController;

  @override
  void initState() {
    bloc = context.read<HomeBloc>();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainUi,
    );
  }

  Widget get _mainUi => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Выйти",
                    style: TextStyleS.s16w600(),
                  ),
                ],
              ),
              SizedBox(height: 22),
              _tabBarField,
              Expanded(child: _tabBarViewField),
            ],
          ),
        ),
      );

  Widget get _tabBarField => BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: null,
              color: AppColor.primaryAppColor,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: AppColor.blackColor,
            tabs: [
              Tab(text: 'Телефон'),
              Tab(text: 'Почта'),
            ],
          );
        },
      );

  Widget get _tabBarViewField => BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return TabBarView(
            controller: _tabController,
            children: [
              Center(child: Text("first")),
              Center(child: Text("second")),
            ],
          );
        },
      );
}
