import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:quitanda_app/src/core/utils/validators.dart';
import 'package:quitanda_app/src/pages/auth/components/custom_text_field.dart';
import 'package:quitanda_app/src/core/theme/colors.dart';
import 'package:quitanda_app/src/pages/auth/controllers/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextInputFormatter cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final TextInputFormatter phoneFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 40),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(40)),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            labelText: 'E-mail',
                            validator: Validators.isEmail,
                            onSaved: (value) =>
                                _authController.user.email = value!,
                          ),
                          CustomTextField(
                            icon: Icons.lock,
                            labelText: 'Password',
                            isSecret: true,
                            validator: Validators.isRequired,
                            onSaved: (value) =>
                                _authController.user.password = value!,
                          ),
                          CustomTextField(
                            icon: Icons.person,
                            labelText: 'Name',
                            validator: Validators.isFullname,
                            onSaved: (value) =>
                                _authController.user.name = value!,
                          ),
                          CustomTextField(
                            icon: Icons.phone,
                            labelText: 'Phone',
                            keyboardType: TextInputType.phone,
                            inputFormatters: [phoneFormatter],
                            validator: Validators.isPhone,
                            onSaved: (value) =>
                                _authController.user.phone = value!,
                          ),
                          CustomTextField(
                            icon: Icons.file_copy,
                            labelText: 'CPF',
                            keyboardType: TextInputType.number,
                            inputFormatters: [cpfFormatter],
                            validator: Validators.isCPF,
                            onSaved: (value) =>
                                _authController.user.cpf = value!,
                          ),
                          SizedBox(
                            height: 50,
                            child: Obx(
                              () => ElevatedButton(
                                onPressed: _authController.isLoading.value ? null : () async {
                                  FocusScope.of(context).unfocus();

                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save(); // call all the TextField's "onSaved" methods
                                    await _authController.signUp();
                                  }
                                },
                                child: _authController.isLoading.value ? const CircularProgressIndicator() : const Text(
                                  'Cadastrar Usuário',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
