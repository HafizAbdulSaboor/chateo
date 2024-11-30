import 'package:chateo/Screen/bottm_bar/provider/bottom_bar_provider.dart';
import 'package:chateo/Screen/call_screen/call_screen.dart';
import 'package:chateo/Screen/group_Screen/group_Screen.dart';
import 'package:chateo/Screen/home_screen/home_screen.dart';
import 'package:chateo/Screen/status_Screen/status_Screen.dart';
import 'package:chateo/utils/colors.dart';
import 'package:chateo/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  final List<Widget> screens = const [
    HomeScreen(),
    StatusScreen(),
    GroupScreen(),
    CallScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomBarProvider>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: BottomAppBar(
            color: AppColors.containerColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBottomBarItem(
                  context,
                  icon: AppImage.homeicon,
                  selectedIcon: AppImage.homeselectedicon,
                  index: 0,
                ),
                _buildBottomBarItem(
                  context,
                  icon: AppImage.statusicon,
                  selectedIcon: AppImage.statusselectedicon,
                  index: 1,
                ),
                _buildBottomBarItem(
                  context,
                  icon: AppImage.groupicon,
                  selectedIcon: AppImage.groupselectedicon,
                  index: 2,
                ),
                _buildBottomBarItem(
                  context,
                  icon: AppImage.callicon,
                  selectedIcon: AppImage.callselectedicon,
                  index: 3,
                ),
              ],
            ),
          ),
        ),
      ),
      body: screens[provider.currentIndex],
      backgroundColor: AppColors.backgroundColor,
    );
  }

  Widget _buildBottomBarItem(
    BuildContext context, {
    required String icon,
    required String selectedIcon,
    required int index,
  }) {
    final provider = Provider.of<BottomBarProvider>(context);
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () => provider.updateIndex(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            provider.currentIndex == index ? selectedIcon : icon,
          ),
          const SizedBox(height: 5),
          if (provider.currentIndex == index)
            Container(
              height: 5,
              width: 5,
              decoration: const BoxDecoration(
                color: AppColors.barcontainerColor,
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
            ),
        ],
      ),
    );
  }
}
