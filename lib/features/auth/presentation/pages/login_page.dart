import 'package:blogger/core/common/widgets/loader.dart';
import 'package:blogger/core/theme/app_platte.dart';
import 'package:blogger/core/utils/show_snackbar.dart';
import 'package:blogger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogger/features/auth/presentation/widgets/auth_field.dart';
import 'package:blogger/features/auth/presentation/widgets/auth_gradiant_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign In.",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              AuthField(controller: emailController, hintText: 'Email'),
              const SizedBox(
                height: 15,
              ),
              AuthField(
                controller: passwordController,
                hintText: 'Password',
                isObsecureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailure) {
                    showSnackBar(context, state.message);
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Loader();
                  }
                  return AuthGradiantButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthSignIn(
                              email: emailController.text,
                              password: passwordController.text));
                        }
                      },
                      text: "Sign In");
                },
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => context.go('/signup'),
                child: RichText(
                  text: TextSpan(
                      text: "Don't have an account? ",
                      children: [
                        TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: AppPallete.gradient2,
                                    fontWeight: FontWeight.bold))
                      ],
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
