import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/common/loading_view.dart';
import 'package:local_man/models/professions.dart';
import 'package:local_man/views/professions/controllers/professions_controllers.dart';

class ProfessionView extends ConsumerStatefulWidget {
  final String professionName;
  const ProfessionView(this.professionName, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfessionViewState();
}

class _ProfessionViewState extends ConsumerState<ProfessionView> {
  //initializes loading as false
  bool loading = false;

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
        .getProfession(professionName: replaceSpace(widget.professionName));
    if (existingProfession != null) {
      setState(() {
        loading = false;
      });

      return existingProfession;
    }
    final newProfession = await ref
        .read(professionControllerProvider.notifier)
        .createProfession(professionName: replaceSpace(widget.professionName));
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
            body: Center(
              child: Text(professionData.name),
            ),
          );
  }
}
