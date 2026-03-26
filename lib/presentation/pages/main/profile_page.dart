import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/data/models/user/user_model.dart';
import 'package:news_watch_app/presentation/constants/assets.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/pages/auth/logic/user_bloc.dart';
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
    context.read<UserBloc>().add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final txt = AppLocalizations.of(context)!;

    return BlocConsumer<UserBloc, UserState>(
      listener: (context, userState) async {
        if (userState is UserLoaded) {
          form.patchValue({
            'username': userState.user.username,
            'firstName': userState.user.firstName,
            'lastName': userState.user.lastName,
            'email': userState.user.email,
          });

          if (userState.user.imagePath != null &&
              userState.user.imagePath!.isNotEmpty) {
            selectedImage = XFile(userState.user.imagePath!);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile loaded successfully!')),
          );
        }

        if (userState is UserError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(userState.message)));
        }
      },
      builder: (context, userState) {
        if (userState is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        }

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
                            if (form.valid && userState is UserLoaded) {
                              final updatedUser = UserModel(
                                userId: userState.user.userId, 
                                username: form.control('username').value,
                                firstName: form.control('firstName').value,
                                lastName: form.control('lastName').value,
                                email: form.control('email').value,
                                imagePath: selectedImage?.path,
                              );

                              context.read<UserBloc>().add(
                                UpdateUserEvent(updatedUser),
                              );
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
