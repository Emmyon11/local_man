import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/models/professions.dart';
import 'package:local_man/models/user_model.dart';
import 'package:local_man/theme/pallete.dart';
import 'package:local_man/views/profile/widgets/info_text.dart';

class ProfileInformation extends ConsumerWidget {
  final UserModel userInfo;
  final ProfessionModel professionInfo;
  const ProfileInformation(
      {required this.userInfo, required this.professionInfo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Pallete.color2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoText(name: 'Profession', value: professionInfo.name),
          const SizedBox(
            height: 5,
          ),
          InfoText(name: 'Email', value: userInfo.email),
          const SizedBox(
            height: 5,
          ),
          InfoText(name: 'Location', value: userInfo.companyAddress),
        ],
      ),
    );
  }
}
