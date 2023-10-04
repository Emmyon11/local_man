import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/common/error_page.dart';
import 'package:local_man/common/loading_view.dart';

import 'package:local_man/views/auth/controller/auth_controller.dart';
import 'package:local_man/views/home/home_view.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: ref.watch(currUserProvider).when(
              data: (user) {
                return const HomeView();
              },
              error: (error, stackTrace) {
                return ErrorPage(error: error.toString());
              },
              loading: () => const LoadingPage(),
            ));
  }
}
