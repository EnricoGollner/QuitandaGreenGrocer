import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:quitanda_app/src/pages/auth/components/custom_text_field.dart';
import 'package:quitanda_app/src/core/theme/colors.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextInputFormatter cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final TextInputFormatter phoneFormatter = MaskTextInputFormatter(
    mask: '(###) #####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const CustomTextField(
                            icon: Icons.email,
                            labelText: 'E-mail',
                          ),
                          const CustomTextField(
                            icon: Icons.lock,
                            labelText: 'Senha',
                            isSecret: true,
                          ),
                          const CustomTextField(
                            icon: Icons.person,
                            labelText: 'Nome',
                          ),
                          CustomTextField(
                            icon: Icons.phone,
                            labelText: 'Celular',
                            keyboardType: TextInputType.number,
                            inputFormatters: [phoneFormatter],
                          ),
                          CustomTextField(
                            icon: Icons.file_copy,
                            labelText: 'CPF',
                            keyboardType: TextInputType.number,
                            inputFormatters: [cpfFormatter],
                          ),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                'Cadastrar Usuário',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
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
