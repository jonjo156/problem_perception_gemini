import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problem_perception_landing/features/auth/bloc/auth_bloc.dart';
import 'package:problem_perception_landing/features/auth/presentation/auth_flow_widget.dart';
import 'package:problem_perception_landing/features/favorites/presentation/saved_page.dart';
import 'package:problem_perception_landing/features/home/presentation/home_page.dart';
import 'package:problem_perception_landing/features/profile/presentation/profile_page.dart';

class AppNavigationRail extends StatefulWidget {
  const AppNavigationRail({super.key});

  @override
  State<AppNavigationRail> createState() => _AppNavigationRailState();
}

class _AppNavigationRailState extends State<AppNavigationRail> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  double groupAlignment = -1.0;
  final List<Widget> _pages = const [
    HomePage(),
    SavedPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (dialogContext, state) async {
        if (state.status != AuthStatus.authenticated &&
            state.status != AuthStatus.authenticatedWithProfile) {
          await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const AuthFlowWidget();
            },
          );
        } else if (state.status == AuthStatus.authenticatedWithProfile) {
          // TODO: Double check this doesn't just make authenticated users randomly pop on routes
          while (Navigator.canPop(dialogContext)) {
            Navigator.pop(dialogContext);
          }
        }
      },
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  indicatorShape: ShapeBorder.lerp(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    1,
                  ),
                  // indicatorColor: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).disabledColor,
                  selectedIndex: _selectedIndex,
                  groupAlignment: groupAlignment,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: const <NavigationRailDestination>[
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home_outlined),
                      label: SizedBox(),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.bookmark_border),
                      selectedIcon: Icon(Icons.bookmark_border),
                      label: SizedBox(),
                    ),
                    // NavigationRailDestination(
                    //   icon: Icon(Icons.history),
                    //   selectedIcon: Icon(Icons.history),
                    //   label: SizedBox(),
                    // ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person_outline),
                      label: SizedBox(),
                    ),
                  ],
                ),
                _pages[_selectedIndex]
              ],
            ),
          );
        } else {
          return Scaffold(
            body: _pages[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_border),
                  label: 'Saved',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.history),
                //   label: 'History',
                // ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
