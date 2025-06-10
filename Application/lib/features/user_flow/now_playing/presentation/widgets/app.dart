import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../utils/navigation.dart';
import '../views/coming_soon.dart';
import '../views/now_playing.dart';

class App extends StatefulWidget {
  final int initialTab;

  const App({super.key, this.initialTab = 0});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return DefaultTabController(
      length: 2,
      initialIndex: widget.initialTab,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onPrimary,
            size: 28.sp,
          ),
          elevation: 0,
          leadingWidth: screenWidth * 0.1,
          leading: IconButton(
            onPressed: () {
              navigatePop(context: context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: screenWidth * 0.06,
            ),
          ),
          title: Container(
            width: screenWidth * 0.8,
            height: mediaQuery.size.height * 0.05,
            decoration: BoxDecoration(
              color: const Color(0xFF0F0A2B).withOpacity(.30),
              borderRadius:
                  BorderRadius.circular(12), // Apply BorderRadius here
            ),
            child: TabBar(
              dividerColor: Colors.transparent,
              labelColor: const Color(0xFFEB68E3),
              unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
              // Unselected tab text color
              indicatorColor: const Color(0xFFEB68E3), // Highlight color
              labelStyle: theme.textTheme.labelLarge!
                  .copyWith(fontSize: screenWidth * 0.04),
              tabs: [
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.04),
                  child: Tab(text: lang.nowPlaying),
                ),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.04),
                  child: Tab(text: lang.comingSoon),
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            NowPlaying(), // The Now Playing page
            ComingSoons(), // The Coming Soon page
          ],
        ),
      ),
    );
  }
}
