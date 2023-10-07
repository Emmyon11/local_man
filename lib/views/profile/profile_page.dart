import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/common/error_page.dart';
import 'package:local_man/common/loading_view.dart';
import 'package:local_man/models/user_model.dart';
import 'package:local_man/theme/pallete.dart';
import 'package:local_man/views/professions/controllers/professions_controllers.dart';
import 'package:local_man/views/profile/widgets/profile_information.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final UserModel user;
  const ProfilePage(this.user, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    return Scaffold(
      backgroundColor: Pallete.color4,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Welcome',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Pallete.color2),
              ),
              Text(
                user.fullName,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Pallete.color2),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  user.profilePic,
                  height: 300,
                  width: MediaQuery.of(context).size.width / 1.5,
                  fit: BoxFit.cover,
                ),
              ),
              ref.watch(getUserProfessionByIdProvider(user.profession[0])).when(
                  data: (profession) {
                    return ProfileInformation(
                        userInfo: user, professionInfo: profession!);
                  },
                  error: (error, stackTrace) =>
                      ErrorText(error: error.toString()),
                  loading: () => const LoadingView())
            ],
          ),
        ),
      ),
    );
  }
}
