import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../data/local_storage_service/local_storage_service.dart';
import '../../../../../../utils/app_logs.dart';
import '../Text_filed.dart';

class PaymentText extends StatefulWidget {
  const PaymentText({super.key});

  @override
  State<PaymentText> createState() => PaymentTextState();
}

class PaymentTextState extends State<PaymentText> {
  String? cinemaId;
  final TextEditingController _beneficiaryController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _ibanController = TextEditingController();
  final TextEditingController _swiftCodeController = TextEditingController();

  final RegExp _nameRegExp = RegExp(r"^[a-zA-Z\s]+$");
  final RegExp _numberRegExp = RegExp(r"^[0-9]+$");
  final RegExp _ibanRegExp = RegExp(r"^[A-Z0-9]+$");
  final RegExp _swiftCodeRegExp = RegExp(r"^[A-Z0-9]{8,11}$");

  String? _beneficiaryError;
  String? _countryError;
  String? _bankNameError;
  String? _accountNumberError;
  String? _ibanError;
  String? _swiftCodeError;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPaymentDetails(); // استدعاء الدالة عند فتح الشاشة
  }

  Future<void> fetchPaymentDetails() async {
    try {
      await Future.delayed(const Duration(seconds: 2)); // تأخير 2 ثواني

      String cinemaId =
          extractUsername(LocalStorageService.getUserData() ?? "");

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Cinemas')
          .doc(cinemaId)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;

        _beneficiaryController.text = data['beneficiaryName'] ?? '';
        _countryController.text = data['country'] ?? '';
        _bankNameController.text = data['bankName'] ?? '';
        _accountNumberController.text = data['accountNumber'] ?? '';
        _ibanController.text = data['iban'] ?? '';
        _swiftCodeController.text = data['swiftCode'] ?? '';
      }
    } catch (e) {
      debugPrint("⚠️ Error loading payment info: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> savePaymentDetails() async {
    try {
      CollectionReference cinemas =
          FirebaseFirestore.instance.collection('Cinemas');
      String cinemaId =
          extractUsername(LocalStorageService.getUserData() ?? "");

      await cinemas.doc(cinemaId).update({
        'beneficiaryName': _beneficiaryController.text.trim(),
        'country': _countryController.text.trim(),
        'bankName': _bankNameController.text.trim(),
        'accountNumber': _accountNumberController.text.trim(),
        'iban': _ibanController.text.trim(),
        'swiftCode': _swiftCodeController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Updated Successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('⚠️ Error: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  String extractUsername(String email) {
    AppLogs.errorLog(email.toString());

    // نفترض إن الإيميل دايماً بينتهي بـ @admin.com
    if (email.contains("@")) {
      // بنشيل الجزء بتاع @admin.com ونرجع الاسم
      return email.substring(0, email.indexOf("@admin.com"));
    } else {
      return "Invalid email format"; // لو الإيميل مش بالصيغة المطلوبة
    }
  }

  bool validateFields() {
    setState(() {
      _beneficiaryError =
          _validateName(_beneficiaryController.text.trim(), min: 3, max: 70);
      _countryError =
          _validateName(_countryController.text.trim(), min: 2, max: 40);
      _bankNameError =
          _validateName(_bankNameController.text.trim(), min: 3, max: 50);
      _accountNumberError = _validateNumber(
          _accountNumberController.text.trim(),
          min: 13,
          max: 16);
      _ibanError = _validateIBAN(_ibanController.text.trim(), min: 15, max: 34);
      _swiftCodeError =
          _validateSwift(_swiftCodeController.text.trim(), min: 8, max: 11);
    });

    return _beneficiaryError == null &&
        _countryError == null &&
        _bankNameError == null &&
        _accountNumberError == null &&
        _ibanError == null &&
        _swiftCodeError == null;
  }

  String? _validateName(String value, {int min = 1, int max = 70}) {
    if (value.isEmpty) return "⚠️ This field is required!";
    if (!_nameRegExp.hasMatch(value)) return "⚠️ Only letters allowed!";
    if (value.length < min || value.length > max) {
      return "⚠️ Length must be $min - $max characters!";
    }
    return null;
  }

  String? _validateNumber(String value, {int min = 13, int max = 16}) {
    if (value.isEmpty) return "⚠️ This field is required!";
    if (!_numberRegExp.hasMatch(value)) return "⚠️ Only numbers allowed!";
    if (value.length < min || value.length > max) {
      return "⚠️ Length must be $min - $max digits!";
    }
    return null;
  }

  String? _validateIBAN(String value, {int min = 29, int max = 29}) {
    if (value.isEmpty) return "⚠️ This field is required!";
    if (!value.startsWith('EG')) return "⚠️ IBAN must start with 'EG'!";
    if (!_ibanRegExp.hasMatch(value)) {
      return "⚠️ IBAN must be uppercase letters and numbers!";
    }
    if (value.length != 29) return "⚠️ IBAN must be exactly 29 characters!";

    return null;
  }

  String? _validateSwift(String value, {int min = 8, int max = 11}) {
    if (value.isEmpty) return "⚠️ This field is required!";

    final RegExp swiftPattern = RegExp(r'^[A-Z0-9]+$');
    if (!swiftPattern.hasMatch(value)) {
      return "⚠️ Swift Code must be uppercase letters & numbers!";
    }
    if (value.length < min || value.length > max) {
      return "⚠️ Length must be $min - $max characters!";
    }
    if (value.length >= 6 && value.substring(4, 6) != "EG") {
      return "⚠️ Swift Code must contain 'EG' at position 5-6!";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: _buildTextField("Beneficiary Name*",
                    _beneficiaryController, _beneficiaryError,
                    hint: "Mohamed Ahmed ")),
            Expanded(
                child: _buildTextField(
                    "Country*", _countryController, _countryError,
                    hint: "Egypt")),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
                child: _buildTextField(
                    "Bank Name*", _bankNameController, _bankNameError,
                    hint: "Banque Misr")),
            Expanded(
                child: _buildTextField("Account Number",
                    _accountNumberController, _accountNumberError,
                    hint: "1234567890123456")),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
                child: _buildTextField("IBAN", _ibanController, _ibanError,
                    hint: "EG380019000500000000263180002")),
            Expanded(
                child: _buildTextField(
                    "Swift Code", _swiftCodeController, _swiftCodeError,
                    hint: "BMISEGCX")),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, String? error,
      {String hint = ""}) {
    return TextFiled(
      label: label,
      controller: controller,
      errorText: error,
      hintText: hint,
    );
  }

  @override
  void dispose() {
    _beneficiaryController.dispose();
    _countryController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _ibanController.dispose();
    _swiftCodeController.dispose();
    super.dispose();
  }
}
