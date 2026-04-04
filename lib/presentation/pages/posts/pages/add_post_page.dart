// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_watch_app/core/extensions/scaffold_extension.dart';
import 'package:news_watch_app/cubits/add_post/cubit/add_post_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_state.dart';
import 'package:news_watch_app/data/models/post/post_model.dart';
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
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> pickImage() async {
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      setState(() => selectedImage = image);
    }
  }

  void _submitPost(BuildContext context, String userId) {
    if (headingController.text.isEmpty || descriptionController.text.isEmpty) {
      context.showSnackBarMessage("Please fill heading and description fields");
      return;
    }

    final model = PostModel(
      heading: headingController.text,
      category: categoryController.text,
      description: descriptionController.text,
      imagePath: selectedImage?.path,
      userId: userId,
    );

    final addPostCubit = context.read<AddPostCubit>();
    addPostCubit.addNewPost(model);
    addPostCubit.getPosts(userId);

    Navigator.of(
      context,
      rootNavigator: true,
    ).pushNamed(RouteConstants.mainPage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPostCubit, AddPostState>(
      listener: (context, state) {
        if (state.posts == true) {
          Navigator.of(
            context,
            rootNavigator: true,
          ).pushNamed(RouteConstants.mainPage);
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
            appBar: AppBar(title: const Text("Add Post")),
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
                                children: const [
                                  Icon(
                                    Icons.add_outlined,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Text('Add Post Image'),
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
                      title: 'Heading',
                      controller: headingController,
                    ),
                    SizedBox(height: Gaps.large),
                    PostElementsWidget(title: 'Tag', controller: tagController),
                    SizedBox(height: Gaps.large),
                    PostElementsWidget(
                      title: 'Category',
                      controller: categoryController,
                    ),
                    SizedBox(height: Gaps.large),
                    PostElementsWidget(
                      title: 'Description',
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
                                : () => _submitPost(context, currentUserId!),
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
                                : const Text(
                                    'Post',
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
