import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String email = '';

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = '';

  @observable
  bool passwordVisible = false;

  @observable
  bool loggedIn = false;

  @action
  void togglePasswordVisibility() => passwordVisible = !passwordVisible;

  @action
  void setPassword(String value) => password = value;

  @observable
  bool loading = false;

  @computed
  bool get isEmailValid =>
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
          .hasMatch(email);

  @computed
  bool get isPasswordValid => password.length > 6;

  @computed
  Future<void> Function() get loginPressed {
    return (isEmailValid && isPasswordValid && !loading) ? login : () async {};
  }

  @action
  Future<void> login() async {
    loading = true;

    await Future.delayed(const Duration(seconds: 2));

    loading = false;
    loggedIn = true;

    email = "";
    password = "";
  }

  @computed
  bool get isFormValid => isEmailValid && isPasswordValid;

  @action
  void logout() {
    loggedIn = false;
  }
}
