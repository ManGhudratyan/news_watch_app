// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_watch_app/core/extensions/scaffold_extension.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/cubits/add_post/cubit/add_post_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_state.dart';
import 'package:news_watch_app/presentation/constants/constants.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/pages/posts/widgets/post_elements_widget.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final ImagePicker imagePicker = ImagePicker();
  XFile? selectedImage;

  final TextEditingController headingController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedCategory;

  Future<void> pickImage() async {
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      setState(() => selectedImage = image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return BlocListener<AddPostCubit, AddPostState>(
      listener: (context, addPostState) {
        if (addPostState.posts == true) {
          // Navigator.of(
          //   context,
          //   rootNavigator: true,
          // ).pushNamed(RouteConstants.mainPage);
          context.push(RouteConstants.mainPage);
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          if (authState.user == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final currentUserId = authState.user?.userId;
          return Scaffold(
            appBar: AppBar(title: Text(text.txtAddPost)),
            body: Padding(
              padding: EdgeInsets.all(Gaps.large),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 207, 206, 206),
                          borderRadius: BorderRadius.circular(
                            Constants.borderRadiusCircular,
                          ),
                          border: Border.all(color: const Color(0xFFA2A1A1)),
                        ),
                        width: Constants.addPostContainerSize,
                        height: Constants.addPostContainerSize,
                        child: selectedImage == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_outlined,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Text(text.txtAddPostImage),
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  Constants.borderRadiusCircular,
                                ),
                                child: Image.file(
                                  File(selectedImage!.path),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: Gaps.large),
                    PostElementsWidget(
                      title: text.txtHeading,
                      controller: headingController,
                    ),
                    SizedBox(height: Gaps.large),
                    PostElementsWidget(
                      title: text.txtTag,
                      controller: tagController,
                    ),
                    SizedBox(height: Gaps.large),
                    DropdownButtonFormField<String>(
                      hint: Text(text.txtSelectCategory),
                      initialValue: selectedCategory,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'popular',
                          child: Text(text.txtPopular),
                        ),
                        DropdownMenuItem(
                          value: 'politics',
                          child: Text(text.txtPolitics),
                        ),
                        DropdownMenuItem(
                          value: 'tech',
                          child: Text(text.txtTech),
                        ),
                        DropdownMenuItem(
                          value: 'healthy',
                          child: Text(text.txtHealthy),
                        ),
                        DropdownMenuItem(
                          value: 'science',
                          child: Text(text.txtScience),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedCategory = value;
                          });
                        }
                      },
                    ),
                    SizedBox(height: Gaps.large),
                    PostElementsWidget(
                      title: text.txtDescription,
                      controller: descriptionController,
                    ),
                    SizedBox(height: Gaps.larger),
                    BlocBuilder<AddPostCubit, AddPostState>(
                      builder: (context, addPostState) {
                        final isLoading = addPostState.loading;
                        return Center(
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                                    final success = await context
                                        .read<AddPostCubit>()
                                        .submitPost(
                                          heading: headingController.text,
                                          description:
                                              descriptionController.text,
                                          category:
                                              selectedCategory ??
                                              text.txtCategory,
                                          userId: currentUserId!,
                                          imagePath: selectedImage?.path,
                                          tag: tagController.text,
                                          username: authState.user?.username,
                                        );

                                    if (!context.mounted) return;

                                    if (success) {
                                      // Navigator.of(
                                      //   context,
                                      //   rootNavigator: true,
                                      // ).pushNamed(RouteConstants.mainPage);
                                      context.push(RouteConstants.mainPage);
                                    } else {
                                      context.showSnackBarMessage(
                                        text.txtFillHeadingDescription,
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlueAccent,
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    text.txtPost,
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
