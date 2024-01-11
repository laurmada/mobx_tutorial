import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_tutorial/screens/list_screen.dart';
import 'package:mobx_tutorial/stores/login_store.dart';
import 'package:mobx_tutorial/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginStore loginStore = LoginStore();

  late ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    loginStore = Provider.of<LoginStore>(context);

    disposer = reaction((_) => loginStore.loggedIn, (loggedIn) {
      if (loggedIn) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const ListScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 16,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Observer(builder: (_) {
                    return CustomTextField(
                      textInputType: TextInputType.emailAddress,
                      onChanged: loginStore.setEmail,
                      enabled: !loginStore.loading,
                      controller: emailController,
                      hint: 'Email',
                      prefix: const Icon(Icons.account_circle),
                    );
                  }),
                  const SizedBox(height: 16),
                  Observer(builder: (_) {
                    return CustomTextField(
                      textInputType: TextInputType.visiblePassword,
                      onChanged: loginStore.setPassword,
                      enabled: !loginStore.loading,
                      controller: passwordController,
                      hint: 'Password',
                      obscure: !loginStore.passwordVisible,
                      prefix: const Icon(Icons.lock,
                          color: Colors.deepPurpleAccent),
                      suffix: GestureDetector(
                        onTap: loginStore.togglePasswordVisibility,
                        child: Icon(
                          loginStore.passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  Observer(builder: (_) {
                    return SizedBox(
                      height: 44,
                      child: TextButton(
                        onPressed: loginStore.loginPressed,
                        style: TextButton.styleFrom(
                          backgroundColor: loginStore.isFormValid
                              ? Colors.deepPurpleAccent
                              : Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        child: loginStore.loading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }
}
