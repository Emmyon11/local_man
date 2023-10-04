import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/common/error_page.dart';
import 'package:local_man/common/loading_view.dart';

import 'package:local_man/views/auth/controller/auth_controller.dart';
import 'package:local_man/views/home/widgets/home_page.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  String img = '';

  @override
  Widget build(BuildContext context) {
    return
        //check if the user is in the data base via future provider with riverpod
        ref.watch(currUserDocProvider).when(
            data: (userData) {
              if (userData != null) {
                return HomePage(userData);
              }
              //save the user data if its not in the database
              return ref.watch(saveCurrUserProvider).when(
                  data: (data) {
                    if (data != null) {
                      return HomePage(data);
                    }
                    return const Center(child: Text('Cant save this user'));
                  },
                  error: (error, stackTrace) {
                    return ErrorPage(error: error.toString());
                  },
                  loading: () => const LoadingView());
            },
            error: (error, stackTrace) {
              return ErrorPage(error: error.toString());
            },
            loading: () => const LoadingView());
  }
}
