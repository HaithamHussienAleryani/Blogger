import 'package:blogger/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blogger/features/auth/presentation/pages/login_page.dart';
import 'package:blogger/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final routingConfig =
    GoRouter(debugLogDiagnostics: true, initialLocation: '/', routes: [
  GoRoute(
      path: '/',
      builder: (context, _) =>
          BlocSelector<AppUserCubit, AppUserState, bool>(selector: (state) {
            debugPrint("The user cubit state is ${state.runtimeType}");
            return state is AppUserLoggedIn;
          }, builder: (context, isLoggedIn) {
            if (isLoggedIn) {
              return const Scaffold(
                body: Center(
                  child: Text("Logged in "),
                ),
              );
            } else {
              return const LoginPage();
            }
          }),
      routes: [
        GoRoute(
            path: 'signup', builder: (context, state) => const SignUpPage()),
      ]),
]);
