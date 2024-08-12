import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/grey_textfield.dart';
import '../../bloc/auth_bloc.dart';

class LoginDialog extends StatelessWidget {
  LoginDialog({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(
          top: 70,
          bottom: 34,
        ),
        child: Text(
          'Welcome to Problem Perception',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 42.0, vertical: 8),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            GreyTextfield(
              hintText: 'Email Address',
              controller: emailController,
            ),
            const SizedBox(height: 24),
            GreyTextfield(
              hintText: 'Password',
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 38),
            InkWell(
              onTap: () {
                context.read<AuthBloc>().add(UserLoginEvent(
                    email: emailController.text,
                    password: passwordController.text));
              },
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Theme.of(context).primaryColor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Get early access',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.normal)),
                      const SizedBox(width: 8),
                      const Icon(Icons.chevron_right)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
