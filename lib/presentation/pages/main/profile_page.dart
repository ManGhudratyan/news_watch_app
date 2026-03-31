import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_state.dart';
import 'package:news_watch_app/presentation/constants/assets.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/widgets/profile_form_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FormGroup form = FormGroup({
    'username': FormControl<String>(validators: [Validators.required]),
    'firstName': FormControl<String>(),
    'lastName': FormControl<String>(),
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(validators: [Validators.minLength(8)]),
  });

  final ImagePicker imagePicker = ImagePicker();
  XFile? selectedImage;

  Future<void> pickImage() async {
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    final authCubit = context.read<AuthCubit>();
    final user = authCubit.state.user;

    if (user == null) {
      authCubit.getLoggedInUser();
    } else {
      form.patchValue({
        'username': user.username,
        'firstName': user.firstName,
        'lastName': user.lastName,
        'email': user.email,
      });

      if (user.imagePath != null && user.imagePath!.isNotEmpty) {
        selectedImage = XFile(user.imagePath!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final txt = AppLocalizations.of(context)!;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, authState) async {
        if (authState.user != null) {
          form.patchValue({
            'username': authState.user?.username,
            'firstName': authState.user?.firstName,
            'lastName': authState.user?.lastName,
            'email': authState.user?.email,
          });

          if (authState.user?.imagePath != null &&
              authState.user!.imagePath!.isNotEmpty) {
            selectedImage = XFile(authState.user!.imagePath!);
          }

          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(content: Text('Profile loaded successfully!')),
          // );
        }

        if (authState.error?.isNotEmpty ?? false) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(authState.error ?? '')));
        }
      },
      builder: (context, authState) {
        // if (authState.loading == true) {
        //   return const Center(child: CircularProgressIndicator());
        // }

        return Scaffold(
          appBar: AppBar(title: Text(txt.txtMyProfile), centerTitle: true),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: Gaps.large,
              vertical: Gaps.large,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    screenHeight -
                    kToolbarHeight -
                    MediaQuery.of(context).padding.top,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.15,
                    backgroundImage: selectedImage != null
                        ? FileImage(File(selectedImage!.path))
                        : AssetImage(Assets.userImage) as ImageProvider,
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: pickImage,
                    child: Text(
                      txt.txtChangeProfilePhoto,
                      style: const TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  SizedBox(height: Gaps.large),
                  ReactiveForm(
                    formGroup: form,
                    child: Column(
                      children: [
                        ProfileFormWidget(
                          title: txt.txtUsername,
                          formControl:
                              form.control('username') as FormControl<String>,
                        ),
                        ProfileFormWidget(
                          title: txt.txtFIrstName,
                          formControl:
                              form.control('firstName') as FormControl<String>,
                        ),
                        ProfileFormWidget(
                          title: txt.txtLastName,
                          formControl:
                              form.control('lastName') as FormControl<String>,
                        ),
                        ProfileFormWidget(
                          title: txt.txtEmail,
                          formControl:
                              form.control('email') as FormControl<String>,
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            if (form.valid && authState.user != null) {
                              final updatedUser = authState.user!.copyWith(
                                username: form.control('username').value,
                                firstName: form.control('firstName').value,
                                lastName: form.control('lastName').value,
                                email: form.control('email').value,
                                imagePath: selectedImage?.path,
                              );
                              context.read<AuthCubit>().updateUser(updatedUser);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profile updated!'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            } else {
                              form.markAllAsTouched();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                          ),
                          child: Text(
                            txt.txtUpdateButton,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
