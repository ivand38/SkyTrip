import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/cubit/auth_cubit.dart';
import 'package:travel_app/models/user_model.dart';
import 'package:travel_app/shared/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:travel_app/views/widgets/custom_button.dart';
import 'package:travel_app/views/widgets/text_form_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfileScreen extends StatefulWidget {
  final UserModel user;

  ChangeProfileScreen({required this.user, super.key});

  @override
  State<ChangeProfileScreen> createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController hobbyController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? image;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.name;
    hobbyController.text = widget.user.hobby;
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('profile/${widget.user.id}');
      final uploadTask = storageRef.putFile(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  void updateUserProfile() async {
    if (_formKey.currentState!.validate()) {
      String? profilePicUrl = widget.user.profilePic;

      if (image != null) {
        profilePicUrl = await _uploadImage(image!);
      }

      if (profilePicUrl != null) {
        final updatedUser = UserModel(
          id: widget.user.id,
          email: widget.user.email,
          name: nameController.text,
          hobby: hobbyController.text,
          profilePic: profilePicUrl,
          balance: widget.user.balance,
        );

        context.read<AuthCubit>().updateUser(updatedUser);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update profile'),
            backgroundColor: redColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: blackColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: bgColor,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Change Your Profile',
                style: primaryTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: image != null
                                  ? FileImage(image!)
                                  : CachedNetworkImageProvider(
                                      widget.user.profilePic,
                                    ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: _pickImage,
                              child: Text(
                                'Change Profile Picture',
                                style: blueTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: regular,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormWidget(
                        title: 'Full Name',
                        hintText: 'Full Name',
                        controller: nameController,
                      ),
                      const SizedBox(height: 20),
                      TextFormWidget(
                        title: 'Hobby',
                        hintText: 'Hobby',
                        controller: hobbyController,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/main', (route) => false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Profile updated successfully'),
                        backgroundColor: greenColor,
                      ),
                    );
                  } else if (state is AuthFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        backgroundColor: redColor,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }

                  return GestureDetector(
                    onTap: updateUserProfile,
                    child: CustomButton(
                      title: 'Change Profile',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
