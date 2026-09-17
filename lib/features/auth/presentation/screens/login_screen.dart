import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/language_toggle.dart';
import 'register_screen.dart';
import 'reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false; // TODO Phase 2: replace with BlocBuilder<AuthBloc, AuthState>

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO Phase 2: context.read<AuthBloc>().add(LoginRequested(email, password));
      setState(() => _isLoading = true);
    }
  }

  void _onGooglePressed() {
    // TODO Phase 2: context.read<AuthBloc>().add(GoogleLoginRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: context.horizontalPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: context.h(50)),
                Image.asset(
                  'assets/images/logo.png',
                  width: context.w(110),
                  height: context.w(110),
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: context.w(110),
                    height: context.w(110),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2.5),
                    ),
                    child: Icon(Icons.play_arrow_rounded, color: AppColors.primary, size: context.w(55)),
                  ),
                ),
                SizedBox(height: context.h(40)),
                AppTextField(
                  label: '',
                  hint: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Email is required';
                    if (!value.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ),
                SizedBox(height: context.h(16)),
                AppTextField(
                  label: '',
                  hint: 'Password',
                  controller: _passwordController,
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Password is required';
                    if (value.length < 6) return 'Password must be at least 6 characters';
                    return null;
                  },
                ),
                SizedBox(height: context.h(8)),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
                      );
                    },
                    child: Text('Forget Password ?', style: AppTextStyles.link),
                  ),
                ),
                SizedBox(height: context.h(8)),
                PrimaryButton(label: 'Login', isLoading: _isLoading, onPressed: _onLoginPressed),
                SizedBox(height: context.h(16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't Have Account ? ", style: AppTextStyles.body),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const RegisterScreen()),
                        );
                      },
                      child: Text('Create One', style: AppTextStyles.link),
                    ),
                  ],
                ),
                SizedBox(height: context.h(20)),
                Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.divider)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.w(12)),
                      child: Text('OR', style: AppTextStyles.body),
                    ),
                    Expanded(child: Divider(color: AppColors.divider)),
                  ],
                ),
                SizedBox(height: context.h(20)),
                SizedBox(
                  width: double.infinity,
                  height: context.h(52),
                  child: ElevatedButton.icon(
                    onPressed: _onGooglePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    // TODO: swap this icon for the real Google "G" logo asset/svg
                    icon: const Icon(Icons.g_mobiledata, color: Colors.black, size: 28),
                    label: Text('Login With Google',
                        style: AppTextStyles.button.copyWith(color: Colors.black)),
                  ),
                ),
                SizedBox(height: context.h(24)),
                const LanguageToggle(),
                SizedBox(height: context.h(24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}