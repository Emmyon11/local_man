import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_man/common/loading_view.dart';
import 'package:local_man/common/snackbar.dart';
import 'package:local_man/common/utils.dart';
import 'package:local_man/models/user_model.dart';
import 'package:local_man/theme/pallete.dart';
import 'package:local_man/views/home/controllers/user_controller.dart';
import 'package:local_man/views/home/home_view.dart';

class UpdatePage extends ConsumerStatefulWidget {
  final UserModel userData;
  const UpdatePage(this.userData, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdatePageState();
}

class _UpdatePageState extends ConsumerState<UpdatePage> {
  final _formKey = GlobalKey<FormState>();
  File? image;
  String? imageUrl;

  void onPickImages() async {
    final ImagePicker picker = ImagePicker();
    final xImage = await picker.pickImage(source: ImageSource.gallery);
    if (xImage != null) image = File(xImage.path);

    setState(() {});
  }

  Future<String> saveImage({required File file}) async {
    final filePath = await ref
        .read(userControllerProvider.notifier)
        .saveUserImage(file: file);
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    final UserModel userData = widget.userData;

    final TextEditingController fullName =
        TextEditingController(text: userData.fullName);
    final TextEditingController personalAdress =
        TextEditingController(text: userData.personalAdress);
    final TextEditingController age =
        TextEditingController(text: userData.age.toString());
    final TextEditingController companyName =
        TextEditingController(text: userData.companyName);
    final TextEditingController companyAddress =
        TextEditingController(text: userData.companyAddress);
    final TextEditingController discription =
        TextEditingController(text: userData.discription);
    final TextEditingController email =
        TextEditingController(text: userData.email);
    final TextEditingController phoneNo =
        TextEditingController(text: userData.phoneNo);
    bool loading = ref.watch(userControllerProvider);

    return Scaffold(
      body: loading
          ? const LoadingView()
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(30),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Update your profile',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Pallete.color4),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(5),
                        overlayColor:
                            const MaterialStatePropertyAll(Pallete.color4),
                        onTap: onPickImages,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Pallete.color2,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "update your profile image",
                                  style: TextStyle(
                                      fontSize: 20, color: Pallete.color4),
                                ),
                                image != null
                                    ? CircleAvatar(
                                        backgroundImage:
                                            AssetImage(image!.path))
                                    : const Icon(
                                        Icons.add_a_photo,
                                        color: Pallete.color3,
                                      )
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: fullName,
                        validator: (value) {
                          final isNameValid = RegExp(
                                  r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
                              .hasMatch(value!);
                          if (!isNameValid) {
                            return 'Provide a valid name and surname';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        validator: (value) {
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!);
                          if (!emailValid) {
                            return 'Please provide a valid email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phoneNo,
                        validator: (value) {
                          if (value == null || value.length < 9) {
                            return 'your Phone number cannot be less than nine digit';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: age,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.parse(value) < 15) {
                            return 'You must be greater than 15 years of age';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Age',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: personalAdress,
                        decoration: InputDecoration(
                          labelText: 'Personal Address',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: companyName,
                        decoration: InputDecoration(
                          labelText: 'Company Name',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: companyAddress,
                        decoration: InputDecoration(
                          labelText: 'Company Address',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: discription,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        child: ElevatedButton.icon(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Pallete.color2)),
                          onPressed: () async {
                            _formKey.currentState!.validate();
                            if (image != null) {
                              imageUrl = await saveImage(file: image!);
                            }

                            final UserModel updatedUser = UserModel(
                                fullName: fullName.text.isNotEmpty
                                    ? fullName.text
                                    : userData.fullName,
                                personalAdress: personalAdress.text.isNotEmpty
                                    ? personalAdress.text
                                    : userData.personalAdress,
                                age: age.text.isNotEmpty
                                    ? int.parse(age.text)
                                    : userData.age,
                                uid: userData.uid,
                                profession: userData.profession.toList(),
                                companyName: companyName.text.isNotEmpty
                                    ? companyName.text
                                    : userData.companyName,
                                companyAddress: companyAddress.text.isNotEmpty
                                    ? companyAddress.text
                                    : userData.companyAddress,
                                discription: discription.text.isNotEmpty
                                    ? discription.text
                                    : userData.discription,
                                email: email.text,
                                phoneNo: phoneNo.text.isNotEmpty
                                    ? phoneNo.text
                                    : userData.phoneNo,
                                customers: userData.customers.toList(),
                                reviews: userData.reviews.toList(),
                                profilePic: imageUrl ?? userData.profilePic,
                                showcaseImg: userData.showcaseImg.toList());

                            ref
                                .read(userControllerProvider.notifier)
                                .upDateUser(user: updatedUser)
                                .onError((error, stackTrace) {
                              showSnackbar(context, error.toString());
                              return null;
                            });
                            if (context.mounted) {
                              showSnackbar(
                                  context, "Profile updated sucessfully");
                              nextScreenWithOutReplacement(
                                  widget: const HomeView(), context: context);
                            }
                          },
                          icon: Icon(
                            loading ? Icons.circle : Icons.done,
                            color: Pallete.color4,
                          ),
                          label: const Text(
                            'Submit',
                            style: TextStyle(color: Pallete.color4),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
    );
  }
}
