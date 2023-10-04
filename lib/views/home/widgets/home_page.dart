import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/models/user_model.dart';
import 'package:local_man/theme/pallete.dart';
import 'package:local_man/views/home/widgets/professions_list.dart';
import 'package:local_man/views/home/widgets/update_page.dart';

class HomePage extends ConsumerStatefulWidget {
  final UserModel userdata;
  const HomePage(this.userdata, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UpdatePage(widget.userdata),
                      ));
                    });
                  },
                  icon: const Icon(Icons.addchart),
                  label: const Text('update information')),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_business),
                  label: const Text('update business information')),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_business),
                  label: const Text('update business information')),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_business),
                  label: const Text('update business information')),
            ],
          )),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.more_vert,
              color: Pallete.color2,
              size: 30,
            )),
        elevation: 0,
        backgroundColor: Pallete.color4,
        title: const Text(
          'Local Man',
          style: TextStyle(color: Pallete.color2, fontWeight: FontWeight.w800),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CircleAvatar(
                    radius: 18,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        widget.userdata.profilePic,
                        fit: BoxFit.cover,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
      body: const ProfessionsList(),
    );
  }
}
