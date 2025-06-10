import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/button/button_builder.dart';
import '../../payment/data/model/transaction_model.dart';
import '../../payment/presentation/cubit/payment_cubit.dart';

class PaymentTable extends StatefulWidget {
  final List<TransactionModel> transactions;

  const PaymentTable({super.key, required this.transactions});

  @override
  _PaymentTableState createState() => _PaymentTableState();
}

class _PaymentTableState extends State<PaymentTable> {
  String? selectedStatus;
  final int _rowsPerLoad = 10; // عدد الصفوف التي ستضاف عند الضغط على "See More"
  final List<String> paymentStatuses = ['Complete', 'Refund', 'Rejected'];

  @override
  Widget build(BuildContext context) {
    List<TransactionModel> filteredTransactions = (selectedStatus == null
        ? widget.transactions
        : widget.transactions
            .where((t) => t.status == selectedStatus)
            .toList());

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.sp),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Filter', style: TextStyle(color: Colors.black)),
                SizedBox(width: 3.w),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.filter_list, color: Colors.black),
                  onSelected: (value) {
                    setState(() {
                      selectedStatus = value == 'All' ? null : value;
                    });
                  },
                  itemBuilder: (context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem(value: 'All', child: Text('All')),
                    ...paymentStatuses.map((status) => PopupMenuItem(
                          value: status,
                          child: Text(status),
                        )),
                  ],
                ),
              ],
            ),
          ),
          if (filteredTransactions.isEmpty)
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: const Center(
                child: Text(
                  'No transactions found',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 70.w,
                columns: const [
                  DataColumn(label: Text('Transaction ID')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Payment Status')),
                ],
                rows: filteredTransactions.map((transaction) {
                  Color statusColor;
                  switch (transaction.status) {
                    case 'Complete':
                      statusColor = const Color(0xFF4AA785);
                      break;
                    case 'Refund':
                      statusColor = const Color(0xFFFFC555);
                      break;
                    case 'Rejected':
                      statusColor = Colors.grey;
                      break;
                    default:
                      statusColor = Colors.black;
                  }

                  return DataRow(cells: [
                    DataCell(Text(
                      "#${transaction.id}",
                      style: const TextStyle(color: Colors.black),
                    )),
                    DataCell(Row(
                      children: [
                        Icon(Icons.calendar_today,
                            color: Colors.black, size: 3.sp),
                        SizedBox(width: 5.w),
                        Text(
                          parseDate(transaction.date) ?? 'N/A',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    )),
                    DataCell(Row(
                      children: [
                        Container(
                          width: 3.w,
                          height: 3.w,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          transaction.status,
                          style: TextStyle(color: statusColor),
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            ),
          BlocBuilder<PaymentCubit, PaymentState>(
            builder: (context, state) {
              if (state is TransactionLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Padding(
                  padding: EdgeInsets.only(top: 16.h), // Add some spacing
                  child: ButtonBuilder(
                    text: 'See More',
                    onTap: () {
                      PaymentCubit.get(context).getAllTransactions();

                      // setState(() {
                      //   _visibleRows += _rowsPerLoad;
                      // });
                    },
                    width: 35.w, // Custom width
                    height: 40.h, // Custom height
                    buttonColor:
                        const Color(0xFF560B76), // Transparent background
                    frameColor: const Color(0xFF560B76), // Grey border
                    borderRadius: 20.0, // Less rounded corners
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 6.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

String parseDate(String createdAt) {
  DateTime date = DateTime.parse(createdAt);

  String month = _getMonthName(date.month); // February مثلاً
  int day = date.day; // 19
  int year = date.year; // 2025

  return "$month , $day, $year";
}

String _getMonthName(int monthNumber) {
  const months = [
    'January',
    'Feb',
    'Mar',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  return months[monthNumber - 1];
}
