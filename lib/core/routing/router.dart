import 'package:blogger/features/auth/presentation/pages/login_page.dart';
import 'package:blogger/features/auth/presentation/pages/signup_page.dart';
import 'package:go_router/go_router.dart';

final routingConfig =
    GoRouter(debugLogDiagnostics: true, initialLocation: '/', routes: [
  GoRoute(path: '/', builder: (context, state) => const LoginPage(), routes: [
    GoRoute(path: 'signup', builder: (context, state) => const SignUpPage()),
  ]),
]);
