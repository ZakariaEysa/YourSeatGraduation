import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/halls2/widgets/seat_number.dart';
import 'package:yourseatgraduationproject/features/admin_flow/halls2/widgets/seat_price.dart';
import '../../../../widgets/text_field/text_field/new_text_field_builder.dart';
import '../../../../widgets/validators/validators.dart';

class BasicHall extends StatefulWidget {
  const BasicHall({super.key});

  @override
  BasicHallState createState() => BasicHallState();
}

class BasicHallState extends State<BasicHall> {
  final TextEditingController _hallNameController = TextEditingController();
  final TextEditingController _vipSeatCountController = TextEditingController();
  final TextEditingController _premiumSeatCountController =
      TextEditingController();
  final TextEditingController _standardSeatCountController =
      TextEditingController();
  final TextEditingController _vipSeatPriceController = TextEditingController();
  final TextEditingController _premiumSeatPriceController =
      TextEditingController();
  final TextEditingController _standardSeatPriceController =
      TextEditingController();

  String? _hallNameError;
  String? _vipSeatCountError;
  String? _premiumSeatCountError;
  String? _standardSeatCountError;
  String? _vipSeatPriceError;
  String? _premiumSeatPriceError;
  String? _standardSeatPriceError;

  // Method to set hall data in controllers
  void setHallData(Map<String, dynamic> hallData) {
    setState(() {
      _hallNameController.text = hallData['hallName'] ?? '';
      _vipSeatCountController.text = hallData['vipSeats'] ?? '';
      _premiumSeatCountController.text = hallData['premiumSeats'] ?? '';
      _standardSeatCountController.text = hallData['standardSeats'] ?? '';
      _vipSeatPriceController.text = hallData['vipPrice'] ?? '';
      _premiumSeatPriceController.text = hallData['premiumPrice'] ?? '';
      _standardSeatPriceController.text = hallData['standardPrice'] ?? '';
    });
  }

  bool validate() {
    setState(() {
      _hallNameError = Validators.validateAnyText(
        _hallNameController.text,
        'Hall Name',
      );

      _vipSeatCountError =
          _validateSeatNumber(_vipSeatCountController.text, 'VIP seats');
      _premiumSeatCountError = _validateSeatNumber(
          _premiumSeatCountController.text, 'Premium seats');
      _standardSeatCountError = _validateSeatNumber(
          _standardSeatCountController.text, 'Standard seats');

      _vipSeatPriceError =
          _validatePrice(_vipSeatPriceController.text, 'VIP seat price');
      _premiumSeatPriceError = _validatePrice(
          _premiumSeatPriceController.text, 'Premium seat price');
      _standardSeatPriceError = _validatePrice(
          _standardSeatPriceController.text, 'Standard seat price');
    });

    return _hallNameError == null &&
        _vipSeatCountError == null &&
        _premiumSeatCountError == null &&
        _standardSeatCountError == null &&
        _vipSeatPriceError == null &&
        _premiumSeatPriceError == null &&
        _standardSeatPriceError == null;
  }

  String? _validateSeatNumber(String value, String fieldName) {
    if (value.isEmpty) {
      return 'Field is required';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Only numbers';
    }
    final number = int.tryParse(value);
    if (number == null || number <= 0) {
      return 'At least 1 seat';
    }
    if (number > 10000) {
      return 'At Most 10000';
    }
    return null;
  }

  String? _validatePrice(String value, String fieldName) {
    if (value.isEmpty) {
      return 'Field is required';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Only numbers';
    }
    return null;
  }

  Map<String, dynamic> getHallData() {
    return {
      'hallName': _hallNameController.text,
      'vipSeats': _vipSeatCountController.text,
      'premiumSeats': _premiumSeatCountController.text,
      'standardSeats': _standardSeatCountController.text,
      'vipPrice': _vipSeatPriceController.text,
      'premiumPrice': _premiumSeatPriceController.text,
      'standardPrice': _standardSeatPriceController.text,
    };
  }

  @override
  void dispose() {
    _hallNameController.dispose();
    _vipSeatCountController.dispose();
    _premiumSeatCountController.dispose();
    _standardSeatCountController.dispose();
    _vipSeatPriceController.dispose();
    _premiumSeatPriceController.dispose();
    _standardSeatPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.sp),
      child: Container(
        width: 210.w,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.all(4.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Hall Name
            Row(
              children: [
                Text(
                  "Hall Name : ",
                  style: TextStyle(
                    fontSize: 5.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: NewTextField(
                    controller: _hallNameController,
                    errorText: _hallNameError,
                    borderColor:
                        _hallNameError != null ? Colors.red : Colors.black,
                    onChanged: (value) {
                      setState(() {
                        _hallNameError =
                            Validators.validateAnyText(value, 'Hall Name');
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            SeatNumber(
              vipController: _vipSeatCountController,
              premiumController: _premiumSeatCountController,
              standardController: _standardSeatCountController,
              vipError: _vipSeatCountError,
              premiumError: _premiumSeatCountError,
              standardError: _standardSeatCountError,
              onChanged: () {
                setState(() {
                  _vipSeatCountError = _validateSeatNumber(
                      _vipSeatCountController.text, 'VIP seats');
                  _premiumSeatCountError = _validateSeatNumber(
                      _premiumSeatCountController.text, 'Premium seats');
                  _standardSeatCountError = _validateSeatNumber(
                      _standardSeatCountController.text, 'Standard seats');
                });
              },
            ),
            SizedBox(height: 8.h),
            SeatPrice(
              vipController: _vipSeatPriceController,
              premiumController: _premiumSeatPriceController,
              standardController: _standardSeatPriceController,
              vipError: _vipSeatPriceError,
              premiumError: _premiumSeatPriceError,
              standardError: _standardSeatPriceError,
              onChanged: () {
                setState(() {
                  _vipSeatPriceError = _validatePrice(
                      _vipSeatPriceController.text, 'VIP seat price');
                  _premiumSeatPriceError = _validatePrice(
                      _premiumSeatPriceController.text, 'Premium seat price');
                  _standardSeatPriceError = _validatePrice(
                      _standardSeatPriceController.text, 'Standard seat price');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
