import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/common_widgets/async_value_ui.dart';
import 'package:to_do/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:to_do/features/authentication/presentation/widgets/common_text_field.dart';
import 'package:to_do/routes/routes.dart';
import 'package:to_do/utils/app_styles.dart';
import 'package:to_do/utils/size_config.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();

  bool isChecked = false;
  bool _obscurePassword = true;

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
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
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
    SizeConfig.init(context);
    final state = ref.watch(authControllerProvider);
    ref.listen<AsyncValue>(authControllerProvider, (_, state) {
      state.showAlertDialogError(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: AppStyles.headingTextStyle.copyWith(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.getProportionateScreenWidth(20),
          vertical: SizeConfig.getProportionateScreenHeight(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),
            Text(
              'Welcome Back!',
              style: AppStyles.headingTextStyle.copyWith(
                fontSize: 24,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(5)),
            Text(
              'Login to continue',
              style: AppStyles.normalTextStyle.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

            // Email Field
            Text(
              'Email',
              style: AppStyles.headingTextStyle.copyWith(
                fontSize: 16,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
            CommonTextField(
              hintText: 'Enter your email',
              textInputType: TextInputType.emailAddress,
              controller: _emailEditingController,
              prefixIcon: Icon(
                Icons.email,
                color: Colors.blue.shade400,
                size: 20,
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),

            // Password Field
            Text(
              'Password',
              style: AppStyles.headingTextStyle.copyWith(
                fontSize: 16,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
            CommonTextField(
              hintText: 'Enter your password',
              textInputType: TextInputType.text,
              obscureText: _obscurePassword,
              controller: _passwordEditingController,
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.blue.shade400,
                size: 20,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey.shade600,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(15)),

            // Remember Me & Forgot Password
            SizedBox(height: SizeConfig.getProportionateScreenHeight(25)),

            // Login Button
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: _validateDetails,
              child: Container(
                alignment: Alignment.center,
                height: SizeConfig.getProportionateScreenHeight(50),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: state.isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Login',
                        style: AppStyles.titleTextStyle.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(25)),
            // Register Link - Fixed TapGestureRecognizer
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Don\'t have an account? ',
                  style: AppStyles.normalTextStyle,
                  children: [
                    TextSpan(
                      text: 'Register',
                      style: AppStyles.normalTextStyle.copyWith(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.goNamed(AppRoutes.register.name);
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({required IconData icon, required Color color}) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () {
        // Add social login functionality
      },
      child: Container(
        height: SizeConfig.getProportionateScreenHeight(50),
        width: SizeConfig.getProportionateScreenWidth(50),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(child: FaIcon(icon, color: color, size: 24)),
      ),
    );
  }
}
