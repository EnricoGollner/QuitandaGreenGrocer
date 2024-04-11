import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_app/src/core/utils/validators.dart';
import 'package:quitanda_app/src/pages/auth/components/custom_text_field.dart';
import 'package:quitanda_app/src/pages/auth/controllers/auth_controller.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late AuthController _authController;

  @override
  void initState() {
    _authController = Get.find<AuthController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async => await _authController.signOut(),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          CustomTextField(
            isReadOnly: true,
            initialValue: _authController.user.email,
            icon: Icons.mail,
            labelText: 'E-mail',
          ),
          CustomTextField(
            initialValue: _authController.user.name,
            icon: Icons.person,
            labelText: 'Name',
          ),
          CustomTextField(
            isReadOnly: true,
            initialValue: _authController.user.phone,
            icon: Icons.phone,
            labelText: 'Phone',
          ),
          CustomTextField(
            isReadOnly: true,
            initialValue: _authController.user.cpf,
            icon: Icons.file_copy,
            labelText: 'CPF',
            isSecret: true,
          ),
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () => _updatePassword(context),
              child: const Text('Change Password'),
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> _updatePassword(BuildContext context) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final ctrlCurrentPassword = TextEditingController();
    final ctrlNewPassword = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Change Password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    CustomTextField(
                      controller: ctrlCurrentPassword,
                      icon: Icons.lock,
                      labelText: 'Current Password',
                      isSecret: true,
                      validator: Validators.isPasswordGreaterThan7Char,
                    ),
                    CustomTextField(
                      controller: ctrlNewPassword,
                      icon: Icons.lock_outline,
                      labelText: 'New Password',
                      isSecret: true,
                      validator: Validators.isPasswordGreaterThan7Char,
                    ),
                    CustomTextField(
                      icon: Icons.lock_outline,
                      labelText: 'Confirm New Password',
                      isSecret: true,
                      validator: (newPassword) {
                        final String? result =
                            Validators.isPasswordGreaterThan7Char(newPassword);
                        if (result != null) return result;

                        if (newPassword != ctrlNewPassword.text) {
                          return 'Passwords do not match';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 45,
                      child: Obx(
                        () => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: _authController.isLoading.value
                              ? null
                              : () async {
                                  if (formKey.currentState!.validate()) {
                                    await _authController.changePassword(
                                      currentPassword: ctrlCurrentPassword.text,
                                      newPassword: ctrlNewPassword.text,
                                    );
                                  }
                                },
                          child: _authController.isLoading.value
                              ? const CircularProgressIndicator()
                              : const Text('Change Password'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
