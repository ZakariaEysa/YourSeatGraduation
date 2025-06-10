import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/setting/presentation/views/cinema_design.dart';
import 'package:yourseatgraduationproject/features/admin_flow/setting/presentation/views/contract.dart';
import 'package:yourseatgraduationproject/features/admin_flow/setting/presentation/views/payment_info.dart';
import '../views/cinema _info.dart';

class App extends StatefulWidget {
  final int initialTab;

  const App({super.key, this.initialTab = 0});
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return DefaultTabController(
      length: 4,
      initialIndex: widget.initialTab,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: screenWidth * 0.7,
          title: Padding(
            padding: EdgeInsets.all(12.0.sp),
            child: Container(
              width: double.infinity,
              height: mediaQuery.size.height * 0.05,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: TabBar(
                dividerColor: Colors.transparent,
                labelColor: const Color(0xFFEA3EF7),
                unselectedLabelColor: const Color(0xFF434343),
                indicatorColor: const Color(0xFFEA3EF7),
                indicatorWeight: 1.0,
                tabs: [
                  _buildTab(Icons.info_outline, "Cinema info"),
                  _buildTab(Icons.video_label_outlined, "Cinema design"),
                  _buildTab(Icons.payment, "Payment info"),
                  _buildTab(Icons.info, "Contract"),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            CinemaInfo(),
            CinemaDesign(),
            PaymentInfo(),
            Contract(),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(IconData icon, String label) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 5.sp),
          SizedBox(width: 5.w),
          Text(
            label,
            style: TextStyle(fontSize: 5.sp),
          ),
        ],
      ),
    );
  }
}
