import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_app/src/pages/auth/components/custom_text_field.dart';
import 'package:quitanda_app/src/pages/auth/controllers/auth_controller.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async => await Get.find<AuthController>().signOut(),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          CustomTextField(
            isReadOnly: true,
            initialValue: Get.find<AuthController>().user.email,
            icon: Icons.mail,
            labelText: 'E-mail',
          ),
          CustomTextField(
            initialValue: Get.find<AuthController>().user.name,
            icon: Icons.person,
            labelText: 'Name',
          ),
          CustomTextField(
            isReadOnly: true,
            initialValue: Get.find<AuthController>().user.phone,
            icon: Icons.phone,
            labelText: 'Phone',
          ),
          CustomTextField(
            isReadOnly: true,
            initialValue: Get.find<AuthController>().user.cpf,
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
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Change Password',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const CustomTextField(
                    icon: Icons.lock,
                    labelText: 'Current Password',
                    isSecret: true,
                  ),
                  const CustomTextField(
                    icon: Icons.lock_outline,
                    labelText: 'New Password',
                    isSecret: true,
                  ),
                  const CustomTextField(
                    icon: Icons.lock_outline,
                    labelText: 'Confirm New Password',
                    isSecret: true,
                  ),
                  SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('Change Password'),
                    ),
                  ),
                ],
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
