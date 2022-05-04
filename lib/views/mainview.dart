import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multihabit/blocs/router/router_cubit.dart';
import 'package:multihabit/views/dashboard.dart';
import 'package:multihabit/views/leaderboard.dart';
import 'package:multihabit/views/log.dart';
import 'package:multihabit/views/stats.dart';

class MainView extends StatefulWidget {
  MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: _tabIndexFromState(BlocProvider.of<RouterCubit>(context).state),
      vsync: this,
      length: _tabs.length,
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(_) {
    return BlocConsumer<RouterCubit, RouterState>(
      listener: _listener,
      builder: (context, state) => Scaffold(
        body: _body(context),
        bottomNavigationBar: _bottomNavigationBar(context, state),
      )
    );
  }

  void _listener(BuildContext context, RouterState state) {
    final int pageIndex = _tabIndexFromState(BlocProvider.of<RouterCubit>(context).state);
    if (_tabController != null) {
      _tabController?.animateTo(pageIndex,curve: Curves.easeInOut);
    }
  }

  Widget _body(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: _pages(context),
    );
  }

  List<Widget> _pages(BuildContext context) {
    return [
      const DashboardView(),
      const LogPage(),
      const LeaderboardPage(),
      const StatsPage()
    ];
  }

  Widget _bottomNavigationBar(BuildContext contest, RouterState state) {
    return Container(
      color: Colors.brown[900],
      child: TabBar(
        controller: _tabController,
        onTap: (index) {
          switch(index) {
            case 1:
              BlocProvider.of<RouterCubit>(context).goToLog();
              break;
            case 2:
              BlocProvider.of<RouterCubit>(context).goToLeaderboard();
              break;
            case 3:
              BlocProvider.of<RouterCubit>(context).goToStats();
              break;
            default:
              BlocProvider.of<RouterCubit>(context).goToDashboard();
              break;
          }
        },
        tabs: _tabs
      )
    );
  }

  List<Tab> get _tabs => [
    const Tab(
      icon: Icon(Icons.home),
    ),
    const Tab(
      icon: FaIcon(FontAwesomeIcons.noteSticky),
    ),
    const Tab(
      icon: FaIcon(FontAwesomeIcons.medal),
    ),
    const Tab(
      icon: FaIcon(FontAwesomeIcons.chartSimple)
    )
  ];

  int _tabIndexFromState(RouterState state) {
    if (state is LeaderboardState) {
      return 2;
    } else if (state is StatsState) {
      return 3;
    } else if (state is LogState) {
      return 1;
    } else {
      return 0;
    }
  }
}
