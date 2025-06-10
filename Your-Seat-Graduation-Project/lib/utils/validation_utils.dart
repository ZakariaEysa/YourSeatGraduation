bool isValidEmail(String email) {
  return RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$').hasMatch(email);
}

isValidPassword(String password) {
  return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
      .hasMatch(password);
}

//final isValidPassword = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

final egyptianPhoneRegex = RegExp(r'^[1][0125][0-9]{8}$');

// final nameRegex = RegExp(r'^[A-Za-z]{3,20}(?: [A-Za-z]{3,20})*$');
final nameRegex = RegExp(r'^[A-Za-z]{3,20}(?: [A-Za-z]{3,20})*\s*$');

/*
Be at least 8 characters long.
Contain at least one uppercase letter.
Contain at least one lowercase letter.
Contain at least one digit.
Contain at least one special character from the set !@#$&*~
*/
