bool isValidEmail(String email) {
  return RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$').hasMatch(email);
}

isValidPassword(String password) {
  return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
      .hasMatch(password);
}

final egyptianPhoneRegex = RegExp(r'^[1][0125][0-9]{8}$');
final nameRegex = RegExp(r'^[A-Za-z]{3,20}(?: [A-Za-z]{3,20})*\s*$');

final RegExp nameRegExp = RegExp(r"^[a-zA-Z\s]+$");
final RegExp emailRegExp =
    RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
final RegExp phoneRegExp = RegExp(r"^[0-9]{11}$");

// ✅ التحقق من الاسم
String? validateName(String value) {
  if (value.isEmpty) return "⚠️ This field is required!";
  if (!nameRegExp.hasMatch(value)) return "⚠️ Only letters allowed!";
  return null;
}

// ✅ التحقق من الإيميل
String? validateEmail(String value) {
  if (value.isEmpty) return "⚠️ This field is required!";
  if (!emailRegExp.hasMatch(value)) return "⚠️ Enter a valid email!";
  return null;
}

// ✅ التحقق من الرقم
String? validatePhone(String value) {
  if (value.isEmpty) return "⚠️ This field is required!";
  if (!RegExp(r'^(010|011|012|015)[0-9]{8}$').hasMatch(value)) {
    return "⚠️ Must start with 010, 011, 012, or 015 and be 11 digits total!";
  }
  return null;
}
