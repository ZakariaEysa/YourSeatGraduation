// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:yourseatgraduationproject/features/admin_flow/homepage/widgets/sales_dash.dart';
//
// class SalesOverview extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.grey[200],
//       width: 260.w,
//       padding: EdgeInsets.all(8.sp),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Today's Sales",
//             style: TextStyle(
//               color: const Color(0xFF151D48),
//               fontSize: 5.sp,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 3.h),
//           Text(
//             "Sales Summary",
//             style: TextStyle(
//               color:  Colors.grey,
//               fontSize: 5.sp,
//
//             ),
//           ),
//           SizedBox(height: 8.h),
//
//           Row(
//             children: [
//               const SalesDash(
//                 imagePath: "assets/images/saledash1.png",
//                 colorHex: '#FFE2E5',
//                 value: "\$1k",
//                 title: "Total Income",
//                 update: "+8% from yesterday",
//                 colorContainer: "#FA5A7D",
//               ),
//               SizedBox(width: 5.w),
//               const SalesDash(
//                 imagePath: "assets/images/sale3.png",
//                 colorHex: '#FFF4DE',
//                 value: "300",
//                 title: "Total Users",
//                 update: "+5% from yesterday",
//                 colorContainer: "#FF947A",
//               ),
//               SizedBox(width: 5.w),
//               const SalesDash(
//                 imagePath: "assets/images/salesdashbord3.png",
//                 colorHex: '#DCFCE7',
//                 value: "5",
//                 title: "Total Movies",
//                 update: "+1.2% from yesterday",
//                 colorContainer: "#3CD856",
//               ),
//               SizedBox(width: 5.w),
//               SalesDash(
//                 imagePath: "assets/images/salesdashbord4.png",
//                 colorHex: '#E7E0E9',
//                 value: "8",
//                 title: "New Customers",
//                 update: "+0.5% from yesterday",
//                 colorContainer: "#BF83FF",
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/homepage/widgets/sales_dash.dart';

import '../cubit/sales_dash_cubit/sales_dash_cubit.dart';

class SalesOverview extends StatefulWidget {
  const SalesOverview({super.key});

  @override
  State<SalesOverview> createState() => _SalesOverviewState();
}

class _SalesOverviewState extends State<SalesOverview> {
  @override
  Widget build(BuildContext context) {
    context.read<SalesDashCubit>().getTotalIncome();
    context.read<SalesDashCubit>().getTotalMovies();

    return Container(
      color: Colors.grey[200],
      width: 260.w,
      padding: EdgeInsets.all(8.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Sales",
            style: TextStyle(
              color: const Color(0xFF151D48),
              fontSize: 5.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            "Sales Summary",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 5.sp,
            ),
          ),
          SizedBox(height: 8.h),
          BlocBuilder<SalesDashCubit, SalesDashState>(
            builder: (context, state) {
              String totalIncome = '0';
              String customers = "0";
              String totalCustomers = "0";

              if (state is SalesDashLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SalesDashSuccess) {
                totalIncome = '\$${state.totalIncome ?? 0}';
                customers = "${state.totalCustomers ?? 0}";
                totalCustomers = "${state.totalMovies ?? 0}";
              } else if (state is SalesDashError) {
                totalIncome = 'Error';
              }

              return Row(
                children: [
                  SalesDash(
                    imagePath: "assets/images/saledash1.png",
                    colorHex: '#FFE2E5',
                    value: totalIncome,
                    title: "Total Income",
                    update: "+8% from yesterday",
                    colorContainer: "#FA5A7D",
                  ),
                  SizedBox(width: 5.w),
                  SalesDash(
                    imagePath: "assets/images/sale3.png",
                    colorHex: '#FFF4DE',
                    value: customers,
                    title: "Total Users",
                    update: "+5% from yesterday",
                    colorContainer: "#FF947A",
                  ),
                  SizedBox(width: 5.w),
                  SalesDash(
                    imagePath: "assets/images/salesdashbord3.png",
                    colorHex: '#DCFCE7',
                    value: totalCustomers,
                    title: "Total Movies",
                    update: "+1.2% from yesterday",
                    colorContainer: "#3CD856",
                  ),
                  SizedBox(width: 5.w),
                  const SalesDash(
                    imagePath: "assets/images/salesdashbord4.png",
                    colorHex: '#E7E0E9',
                    value: "8",
                    title: "New Customers",
                    update: "+0.5% from yesterday",
                    colorContainer: "#BF83FF",
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
