import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/common/error_page.dart';
import 'package:local_man/common/loading_view.dart';
import 'package:local_man/common/utils.dart';
import 'package:local_man/models/professions.dart';
import 'package:local_man/theme/pallete.dart';
import 'package:local_man/views/home/controllers/user_controller.dart';
import 'package:local_man/views/professions/controllers/professions_controllers.dart';
import 'package:local_man/views/profile/profile_page.dart';

class ProfessionMembersList extends ConsumerStatefulWidget {
  final List<String> members;
  final String professionName;
  const ProfessionMembersList(
      {required this.members, required this.professionName, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfessionMembersListState();
}

class _ProfessionMembersListState extends ConsumerState<ProfessionMembersList> {
  @override
  Widget build(BuildContext context) {
    List<String> membersList = widget.members;
    return ref.watch(professionStreamProvider).when(
        data: (data) {
          if (data.events.contains(
              'databases.*.collections.*.documents.04102323${widget.professionName}.update')) {
            final profession = ProfessionModel.fromMap(data.payload);
            final newList = profession.members;
            if (newList.isNotEmpty) {
              membersList = newList;
            }
          }
          return Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: membersList.length,
                itemBuilder: (context, index) {
                  return ref.watch(userDocProvider(membersList[index])).when(
                        data: (user) {
                          return ListTile(
                            leading: InkWell(
                              onTap: () {
                                setState(() {
                                  nextScreen(
                                      widget: ProfilePage(user),
                                      context: context);
                                });
                              },
                              child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(user!.profilePic)),
                            ),
                            title: Text(user.fullName),
                          );
                        },
                        error: (error, stackTrace) {
                          return ErrorText(error: error.toString());
                        },
                        loading: () => const LoadingView(),
                      );
                },
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          return ErrorText(error: error.toString());
        },
        loading: () => Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: membersList.length,
                  itemBuilder: (context, index) {
                    return ref.watch(userDocProvider(membersList[index])).when(
                          data: (user) {
                            return ListTile(
                              leading: InkWell(
                                onTap: () {
                                  setState(() {
                                    nextScreen(
                                        widget: ProfilePage(user),
                                        context: context);
                                  });
                                },
                                child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(user!.profilePic)),
                              ),
                              title: Text(
                                user.fullName,
                                style: const TextStyle(
                                    color: Pallete.color4,
                                    fontWeight: FontWeight.w500),
                              ),
                              trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.chat,
                                    size: 40,
                                    color: Pallete.color4,
                                  )),
                            );
                          },
                          error: (error, stackTrace) {
                            return ErrorText(error: error.toString());
                          },
                          loading: () => const LoadingView(),
                        );
                  },
                ),
              ),
            ));
  }
}
