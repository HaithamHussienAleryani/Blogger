import 'package:blogger/core/theme/app_platte.dart';
import 'package:blogger/features/auth/presentation/widgets/auth_field.dart';
import 'package:blogger/features/auth/presentation/widgets/auth_gradiant_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign Up.",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              AuthField(controller: nameController, hintText: 'Name'),
              const SizedBox(
                height: 15,
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
              const AuthGradiantButton(
                text: 'Sign Up',
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => context.go('/login'),
                child: RichText(
                  text: TextSpan(
                      text: "Do have an account? ",
                      children: [
                        TextSpan(
                            text: 'Sign In',
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
