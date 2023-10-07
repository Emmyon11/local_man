import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/common/loading_view.dart';
import 'package:local_man/models/professions.dart';
import 'package:local_man/theme/pallete.dart';
import 'package:local_man/views/home/utils/professions_list.dart';
import 'package:local_man/views/professions/controllers/professions_controllers.dart';
import 'package:local_man/views/professions/views/members_list.dart';

class ProfessionView extends ConsumerStatefulWidget {
  final Professions profession;
  const ProfessionView(this.profession, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfessionViewState();
}

class _ProfessionViewState extends ConsumerState<ProfessionView> {
  //initializes loading as false
  bool loading = false;
  bool joinLoading = false;

  late ProfessionModel professionData;

  //function to remove white space from document name
  String replaceSpace(String name) {
    if (name.contains(' ')) {
      return name.replaceAll(' ', '_');
    }
    return name;
  }

  //get profession data or create new profession if it dosen't exist
  Future<ProfessionModel> getProfessionData() async {
    setState(() {
      loading = true;
    });

    final existingProfession = await ref
        .read(professionControllerProvider.notifier)
        .getProfession(professionName: replaceSpace(widget.profession.name));
    if (existingProfession != null) {
      setState(() {
        loading = false;
      });

      return existingProfession;
    }
    final newProfession = await ref
        .read(professionControllerProvider.notifier)
        .createProfession(professionName: replaceSpace(widget.profession.name));
    setState(() {
      loading = false;
    });

    return newProfession;
  }

  @override
  void initState() {
    //initializes getProfessionDatafunction
    getProfessionData().then((value) => professionData = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LoadingPage()
        : Scaffold(
            backgroundColor: Pallete.color2,
            body: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      loading
                          ? const CircularProgressIndicator.adaptive()
                          : IconButton(
                              onPressed: () async {
                                setState(() {
                                  joinLoading = true;
                                });
                                //join a profession by clicking the join button
                                await ref
                                    .read(professionControllerProvider.notifier)
                                    .joinProfession(
                                        professionName: replaceSpace(
                                            widget.profession.name),
                                        members: professionData.members);
                                setState(() {
                                  joinLoading = false;
                                });
                              },
                              icon: const Icon(
                                Icons.add_circle,
                                size: 30,
                                color: Pallete.color4,
                              )),
                      Text(
                        widget.profession.name,
                        style: const TextStyle(
                            fontSize: 25,
                            color: Pallete.color4,
                            fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.info,
                          size: 30,
                          color: Pallete.color4,
                        ),
                      )
                    ],
                  ),
                  Card(
                    elevation: 2,
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      widget.profession.imgPath,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ProfessionMembersList(
                    members: professionData.members,
                    professionName: replaceSpace(widget.profession.name),
                  )
                ],
              ),
            ),
          );
  }
}
