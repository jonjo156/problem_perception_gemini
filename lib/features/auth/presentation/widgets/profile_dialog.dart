import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problem_perception_landing/features/auth/bloc/auth_bloc.dart';

import '../../../../core/widgets/grey_textfield.dart';
import '../../../../design/app_colors.dart';
import '../../models/user_model.dart';

class ProfileDialog extends StatelessWidget {
  ProfileDialog({super.key});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

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
          'Complete Profile',
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
            const SizedBox(height: 44),
            GreyTextfield(
              hintText: 'First name',
              controller: firstNameController,
            ),
            const SizedBox(height: 24),
            GreyTextfield(
              hintText: 'Last Name',
              controller: lastNameController,
            ),
            const SizedBox(height: 24),
            GreyTextfield(
              hintText: 'Phone Number',
              controller: phoneNumberController,
            ),
            const SizedBox(height: 24),
            GreyTextfield(
              hintText: 'Gender',
              controller: genderController,
            ),
            const SizedBox(height: 38),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    context.read<AuthBloc>().add(ProfileCreatedEvent(UserModel(
                          email: state.user?.email ??
                              FirebaseAuth.instance.currentUser!.email!,
                          uid: state.user?.uid ??
                              FirebaseAuth.instance.currentUser!.uid,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          phoneNumber: phoneNumberController.text,
                          gender: genderController.text,
                        )));
                  },
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Complete Sign Up',
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
                );
              },
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
              child: Text(
                'Complete profile later',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
