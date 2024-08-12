import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/widgets/grey_textfield.dart';
import '../../../../design/app_colors.dart';
import '../../bloc/auth_bloc.dart';

class AuthDialog extends StatelessWidget {
  AuthDialog({
    super.key,
  });

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      backgroundColor: AppColors.backgroundColor,
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
            Text(
              'Please enter your email address for early access. We recommend that you sign up using your work email address.',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 44),
            Material(
              elevation: 5,
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              child: InkWell(
                onTap: () {
                  context
                      .read<AuthBloc>()
                      .add(const UserSignUpWithGoogleEvent());
                },
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: Theme.of(context).disabledColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset('images/svgs/google.svg'),
                        Text(
                          'Sign in with Google',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox()
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 44),
            MediaQuery.of(context).size.width > 600
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('images/svgs/line.svg'),
                      const SizedBox(width: 24),
                      Text('Or continue with email',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.normal)),
                      const SizedBox(width: 24),
                      SvgPicture.asset('images/svgs/line.svg'),
                    ],
                  )
                : Text('Or continue with email',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.normal)),
            const SizedBox(height: 34),
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
                context.read<AuthBloc>().add(UserSignUpWithEmailEvent(
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
            const SizedBox(height: 20),
            Text(
              'Already registered? Login',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
