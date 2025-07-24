import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/common_widgets/async_value_ui.dart';
import 'package:to_do/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:to_do/features/authentication/presentation/widgets/common_text_field.dart';
import 'package:to_do/utils/app_styles.dart';
import 'package:to_do/utils/size_config.dart';
import 'package:to_do/routes/routes.dart'; // Add this import if AppRoutes is defined here

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();

  bool isChecked = false;
  
  void _validateDetails() {
    String email = _emailEditingController.text.trim();
    String password = _passwordEditingController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill all fields',
            style: AppStyles.normalTextStyle.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ref
          .read(authControllerProvider.notifier)
          .signInWithEmailAndPassword(email: email, password: password);
    }
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // Initialize SizeConfig

    final state = ref.watch(authControllerProvider);
    ref.listen<AsyncValue>(authControllerProvider, (_, state) {
      state.showAlertDialogError(context);
    });

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            SizeConfig.getProportionateScreenWidth(10),
            SizeConfig.getProportionateScreenHeight(50),
            SizeConfig.getProportionateScreenWidth(10),
            0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Login to your account ', style: AppStyles.titleTextStyle),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(25)),
                CommonTextField(
                  hintText: 'Enter Email...',
                  textInputType: TextInputType.emailAddress,
                  controller: _emailEditingController,
                ),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),
                CommonTextField(
                  hintText: 'Enter Password...',
                  textInputType: TextInputType.text,
                  obscureText: true,
                  controller: _passwordEditingController,
                ),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(15)),
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Text(
                      'I agree to the terms and conditions',
                      style: AppStyles.normalTextStyle,
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(25)),
                InkWell(
                  onTap: _validateDetails,
                  child: Container(
                    alignment: Alignment.center,
                    height: SizeConfig.getProportionateScreenHeight(50),
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 9, 66, 255),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: state.isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            'Login',
                            style: AppStyles.titleTextStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: SizeConfig.getProportionateScreenHeight(1),
                      width: SizeConfig.screenWidth * 0.4,
                      decoration: const BoxDecoration(color: Colors.grey),
                    ),
                    SizedBox(height: SizeConfig.getProportionateScreenWidth(5)),
                    Text('OR', style: AppStyles.normalTextStyle),
                    SizedBox(height: SizeConfig.getProportionateScreenWidth(5)),
                    Container(
                      height: SizeConfig.getProportionateScreenHeight(1),
                      width: SizeConfig.screenWidth * 0.4,
                      decoration: const BoxDecoration(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: SizeConfig.getProportionateScreenHeight(40),
                      width: SizeConfig.screenWidth * 0.25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.google,
                        color: Color.fromARGB(255, 238, 110, 36),
                      ),
                    ),
                    Container(
                      height: SizeConfig.getProportionateScreenHeight(40),
                      width: SizeConfig.screenWidth * 0.25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.apple,
                        color: Colors.black54,
                      ),
                    ),
                    Container(
                      height: SizeConfig.getProportionateScreenHeight(40),
                      width: SizeConfig.screenWidth * 0.25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: AppStyles.normalTextStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to Sign Up screen
                        context.goNamed(AppRoutes.register.name);
                      },
                      child: Text(
                        'Register',
                        style: AppStyles.normalTextStyle.copyWith(
                          color: const Color.fromARGB(255, 9, 66, 255),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
