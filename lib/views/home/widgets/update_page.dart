import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                          onPressed: () async {
                            _formKey.currentState!.validate();

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
                                profilePic: userData.profilePic,
                                showcaseImg: userData.showcaseImg.toList());
                            ref
                                .read(userControllerProvider.notifier)
                                .upDateUser(user: updatedUser)
                                .onError((error, stackTrace) async {
                              showSnackbar(context, error.toString());
                              return null;
                            });
                            showSnackbar(
                                context, "Profile updated sucessfully");
                            nextScreenWithOutReplacement(
                                widget: const HomeView(), context: context);
                          },
                          icon: Icon(loading ? Icons.circle : Icons.done),
                          label: const Text('Submit'),
                        ),
                      )
                    ],
                  )),
            ),
    );
  }
}
