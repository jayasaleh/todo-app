import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/common_widgets/async_value_ui.dart';
import 'package:to_do/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:to_do/features/authentication/presentation/widgets/common_text_field.dart';
import 'package:to_do/utils/app_styles.dart';
import 'package:to_do/utils/size_config.dart';
import 'package:to_do/routes/routes.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _emailEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isChecked = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _validateDetails() {
    String email = _emailEditingController.text.trim();
    String password = _passwordEditingController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
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
    } else if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Passwords do not match',
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
          .createUserWithEmailAndPassword(email: email, password: password);
    }
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    _confirmPasswordController.dispose();
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
          'Register',
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
              'Create Account',
              style: AppStyles.headingTextStyle.copyWith(
                fontSize: 24,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(5)),
            Text(
              'Fill in your details to continue',
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
            SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),

            // Confirm Password Field
            Text(
              'Confirm Password',
              style: AppStyles.headingTextStyle.copyWith(
                fontSize: 16,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
            CommonTextField(
              hintText: 'Confirm your password',
              textInputType: TextInputType.text,
              obscureText: _obscureConfirmPassword,
              controller: _confirmPasswordController,
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Colors.blue.shade400,
                size: 20,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey.shade600,
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(15)),

            // Register Button
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
                        'Register',
                        style: AppStyles.titleTextStyle.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(25)),

            // Login Link
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: AppStyles.normalTextStyle,
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: AppStyles.normalTextStyle.copyWith(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.goNamed(AppRoutes.login.name);
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
}
