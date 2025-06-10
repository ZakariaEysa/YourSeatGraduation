import 'dart:html' as html;

class LocalStorageService {
  static void saveUserData(String email) {
    html.window.localStorage['user_email'] = email;
  }

  static String? getUserData() {
    return html.window.localStorage['user_email'];
  }

  static void clearUserData() {
    html.window.localStorage.remove('user_email');
  }
}
