import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  // TODO Phase 2: pre-fill from the current Firebase user via ProfileBloc.
  final _nameController = TextEditingController(text: 'John Safwat');
  final _phoneController = TextEditingController(text: '01200000000');
  bool _isLoading = false;
  bool _showAvatarGrid = false;
  int _selectedAvatarIndex = 1;

  // TODO: replace with real illustrated avatar images, e.g.
  // assets/images/avatars/avatar_0.png ... avatar_8.png
  final List<IconData> _avatarIcons = const [
    Icons.face_2, Icons.headphones, Icons.face_3,
    Icons.person, Icons.face_4, Icons.face_5,
    Icons.face_6, Icons.person_2, Icons.person_3,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onUpdatePressed() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO Phase 2: context.read<ProfileBloc>().add(UpdateProfileRequested(...));
      setState(() => _isLoading = true);
    }
  }

  void _onDeletePressed() {
    // TODO Phase 2: show a confirmation dialog, then
    // context.read<AuthBloc>().add(DeleteAccountRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(color: AppColors.primary),
        title: Text('Pick Avatar', style: AppTextStyles.heading2.copyWith(color: AppColors.primary)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: context.horizontalPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: context.h(16)),
                GestureDetector(
                  onTap: () => setState(() => _showAvatarGrid = !_showAvatarGrid),
                  child: CircleAvatar(
                    radius: context.w(55),
                    backgroundColor: AppColors.surface,
                    child: Icon(_avatarIcons[_selectedAvatarIndex], color: AppColors.primary, size: context.w(55)),
                  ),
                ),
                if (_showAvatarGrid) ...[
                  SizedBox(height: context.h(20)),
                  Container(
                    padding: EdgeInsets.all(context.w(12)),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _avatarIcons.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        final isSelected = index == _selectedAvatarIndex;
                        return GestureDetector(
                          onTap: () => setState(() {
                            _selectedAvatarIndex = index;
                            _showAvatarGrid = false;
                          }),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.surfaceLight,
                              borderRadius: BorderRadius.circular(12),
                              border: isSelected
                                  ? Border.all(color: AppColors.primary, width: 2.5)
                                  : null,
                            ),
                            child: Icon(_avatarIcons[index], color: AppColors.primary, size: context.w(32)),
                          ),
                        );
                      },
                    ),
                  ),
                ],
                SizedBox(height: context.h(28)),
                AppTextField(
                  label: '',
                  hint: 'Name',
                  controller: _nameController,
                  prefixIcon: Icons.person_outline,
                  validator: (value) =>
                  (value == null || value.isEmpty) ? 'Name is required' : null,
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
                SizedBox(height: context.h(12)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      // TODO Phase 2: navigate to ResetPasswordScreen or trigger Firebase reset email
                    },
                    child: Text('Reset Password', style: AppTextStyles.link),
                  ),
                ),
                SizedBox(height: context.h(40)),
                SizedBox(
                  width: double.infinity,
                  height: context.h(52),
                  child: ElevatedButton(
                    onPressed: _onDeletePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('Delete Account', style: AppTextStyles.button),
                  ),
                ),
                SizedBox(height: context.h(16)),
                PrimaryButton(label: 'Update Data', isLoading: _isLoading, onPressed: _onUpdatePressed),
                SizedBox(height: context.h(24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}