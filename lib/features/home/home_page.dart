import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/core.dart';
import '../auth/presentation/bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      actions: [
        IconButton(
          onPressed: () {
            context.read<AuthBloc>().add(AuthSignOut());
          },
          icon: const Icon(Icons.logout),
        ),
      ],
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Welcome!'),
                  Text(state.user.email),
                ],
              ),
            );
          }
          return const Center(child: Text('Not Authenticated'));
        },
      ),
    );
  }
}
