import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/local_storage_service.dart';
import '../../../../injection.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_balance_wallet_rounded,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 24),
            const Text(
              'Welcome to Ruay Jung',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: Text(
                'Track your expenses and manage your wealth easily.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () async {
                await serviceLocator<LocalStorageService>().setNotFirstTime();
                if (context.mounted) {
                  // Redirect to login (router will handle further redirection if authenticated)
                  context.go('/login');
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              ),
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
