import 'package:blogger/core/routing/router.dart';
import 'package:blogger/core/theme/theme.dart';
import 'package:blogger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogger/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => serviceLocator<AuthBloc>(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Blogger',
      theme: AppTheme.darkThemeMode,
      routerConfig: routingConfig,
    );
  }
}
