import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/common/utils.dart';
import 'package:local_man/theme/pallete.dart';
import 'package:local_man/views/home/utils/professions_list.dart';
import 'package:local_man/views/professions/views/profession_view.dart';

class ProfessionsList extends ConsumerStatefulWidget {
  const ProfessionsList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfessionsListState();
}

class _ProfessionsListState extends ConsumerState<ProfessionsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            width: double.infinity,
            color: Pallete.color2,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: const Text(
              'Select a profession',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Pallete.color4),
            )),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: Professions.values.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
            itemBuilder: (context, index) {
              const List<Professions> items = Professions.values;

              return InkWell(
                borderRadius: BorderRadius.circular(15),
                overlayColor: const MaterialStatePropertyAll(Pallete.color3),
                onTap: () {
                  setState(() {
                    nextScreen(
                        widget: ProfessionView(items[index]), context: context);
                  });
                },
                child: Card(
                  color: Pallete.color4,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      Image.asset(
                        items[index].imgPath,
                        fit: BoxFit.cover,
                        height: 150,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        items[index].name,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Pallete.color2),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
