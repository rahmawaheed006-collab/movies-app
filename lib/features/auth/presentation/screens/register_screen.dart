import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/language_toggle.dart';
import '../../../../core/widgets/avatar_carousel.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  int _selectedAvatarIndex = 1;
  bool _isLoading = false; // TODO Phase 2: replace with BlocBuilder<AuthBloc, AuthState>

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO Phase 2: context.read<AuthBloc>().add(RegisterRequested(
      //   name: _nameController.text, email: ..., password: ...,
      //   phone: ..., avatarIndex: _selectedAvatarIndex,
      // ));
      setState(() => _isLoading = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(color: AppColors.primary),
        title: Text('Register', style: AppTextStyles.heading2.copyWith(color: AppColors.primary)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: context.horizontalPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: context.h(12)),
                AvatarCarousel(onSelected: (i) => _selectedAvatarIndex = i),
                Text('Avatar', style: AppTextStyles.body),
                SizedBox(height: context.h(20)),
                AppTextField(
                  label: '',
                  hint: 'Name',
                  controller: _nameController,
                  prefixIcon: Icons.badge_outlined,
                  validator: (value) =>
                  (value == null || value.isEmpty) ? 'Name is required' : null,
                ),
                SizedBox(height: context.h(16)),
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
                SizedBox(height: context.h(16)),
                AppTextField(
                  label: '',
                  hint: 'Confirm Password',
                  controller: _confirmPasswordController,
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (value) {
                    if (value != _passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
                SizedBox(height: context.h(16)),
                AppTextField(
                  label: '',
                  hint: 'Phone Number',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_outlined,
                  validator: (value) =>
                  (value == null || value.isEmpty) ? 'Phone number is required' : null,
                ),
                SizedBox(height: context.h(28)),
                PrimaryButton(label: 'Create Account', isLoading: _isLoading, onPressed: _onRegisterPressed),
                SizedBox(height: context.h(16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already Have Account ? ', style: AppTextStyles.body),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text('Login', style: AppTextStyles.link),
                    ),
                  ],
                ),
                SizedBox(height: context.h(20)),
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