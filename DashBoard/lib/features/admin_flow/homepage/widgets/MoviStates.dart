import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:yourseatgraduationproject/features/admin_flow/homepage/widgets/status_cell.dart';
import 'package:yourseatgraduationproject/features/admin_flow/homepage/widgets/user_cell.dart';

import 'DetailsButton.dart';
import 'movie_cell.dart';

class MovieStates extends StatefulWidget {
  const MovieStates({super.key});

  @override
  State<MovieStates> createState() => _MovieStatesState();
}

class _MovieStatesState extends State<MovieStates> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290.w,
      height: 400.h,
      color: const Color(0xFFf3f3f3),
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Movie States",
            style: TextStyle(
              color: Colors.black,
              fontSize: 5.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6.h),
          Expanded(child: _buildTable()),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      radius: Radius.circular(8.r),
      thickness: 8.w,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        child: DataTable(
          dataRowMinHeight: 40.h,
          dataRowMaxHeight: 70.h,
          horizontalMargin: 6.w,
          columnSpacing: 6.w,
          columns: _buildHeaders(),
          rows: _buildRows(),
        ),
      ),
    );
  }

  List<DataColumn> _buildHeaders() {
    final headers = [
      'No.',
      'User no.',
      'Movies',
      'Status',
      'Earning',
      'Details'
    ];

    return headers.map((title) {
      return DataColumn(
        label: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontSize: 5.sp,
          ),
        ),
      );
    }).toList();
  }

  List<DataRow> _buildRows() {
    final List<Map<String, dynamic>> data = [
      {
        'no': '01',
        'userNo': '6465',
        'title': 'Avengers: Infinity War',
        'image': 'assets/images/Avengers.png',
        'available': true,
        'earning': '\$35.44',
      },
      {
        'no': '02',
        'userNo': '5665',
        'title': 'Guardian Of The Galaxy',
        'image': 'assets/images/Guardian.png',
        'available': false,
        'earning': '\$0.00',
      },
      {
        'no': '03',
        'userNo': '1755',
        'title': 'Avatar 2: The Way Of Water',
        'image': 'assets/images/Avatar.png',
        'available': true,
        'earning': '\$23.50',
      },
    ];

    return data.map((item) {
      return DataRow(
        cells: [
          DataCell(_buildText(item['no'])),
          DataCell(UserCell(userNo: item['userNo'])),
          DataCell(MovieCell(imagePath: item['image'], title: item['title'])),
          DataCell(StatusCell(isAvailable: item['available'])),
          DataCell(_buildText(item['earning'])),
          const DataCell(DetailsButton()),
        ],
      );
    }).toList();
  }

  Widget _buildText(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFF656575),
          fontSize: 5.sp,
        ),
      ),
    );
  }
}
