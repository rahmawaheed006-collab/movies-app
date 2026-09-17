import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onVerifyPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO Phase 2: context.read<AuthBloc>().add(ResetPasswordRequested(email));
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
        title: Text('Forget Password', style: AppTextStyles.heading2.copyWith(color: AppColors.primary)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: context.horizontalPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: context.h(24)),
                // TODO: replace with the real illustration:
                // Image.asset('assets/images/forget_password_illustration.png')
                Container(
                  width: context.w(220),
                  height: context.h(220),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.lock_reset_rounded, color: AppColors.primary, size: context.w(70)),
                ),
                SizedBox(height: context.h(32)),
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
                SizedBox(height: context.h(20)),
                PrimaryButton(label: 'Verify Email', isLoading: _isLoading, onPressed: _onVerifyPressed),
              ],
            ),
          ),
        ),
      ),
    );
  }
}