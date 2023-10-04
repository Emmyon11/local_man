import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_man/common/loading_view.dart';
import 'package:local_man/common/snackbar.dart';
import 'package:local_man/common/utils.dart';
import 'package:local_man/theme/pallete.dart';
import 'package:local_man/views/auth/controller/auth_controller.dart';
import 'package:local_man/views/home/home_view.dart';

class Login extends ConsumerWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Pallete.color2,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Pallete.color3,
        title: const Text(
          'Local Man',
          style: Pallete.titleText,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 1.3,
                child: SvgPicture.asset('assets/svg/login_display.svg'),
              ),
              const Text(
                'Login with socials',
                style: TextStyle(
                    color: Pallete.color4,
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svg/google_logo.svg'),
                  TextButton(
                    child: const Chip(
                        side: BorderSide.none,
                        backgroundColor: Pallete.color3,
                        avatar: Icon(
                          Icons.login,
                          color: Pallete.color1,
                        ),
                        label: Text(
                          'Login',
                          style: TextStyle(
                              color: Pallete.color1,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        )),
                    onPressed: () {
                      ref.read(loginProvider('google')).when(
                        data: (data) {
                          nextScreen(
                              widget: const HomeView(), context: context);
                        },
                        error: (error, stackTrace) {
                          showSnackbar(context, error.toString());
                        },
                        loading: () {
                          LoadingView;
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
