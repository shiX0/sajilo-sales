import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/app/navigator/navigator.dart';
import 'package:sajilo_sales/core/common/custom_alert.dart';
import 'package:sajilo_sales/core/common/custom_sheet.dart';
import 'package:sajilo_sales/core/shared_prefs/app_theme_prefs.dart';
import 'package:sajilo_sales/core/shared_prefs/user_shared_prefs.dart';
import 'package:sajilo_sales/features/auth/presentation/view/login_view.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
                radius: 40,
                backgroundColor: Colors.purpleAccent[100],
                child: const Icon(Icons.person_2_rounded,
                    size: 40, color: Colors.white)),
            const SizedBox(height: 16),
            const Text(
              'John Doe', // Replace with the user's name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            Column(
              children: [
                TextButton.icon(
                  onPressed: () {
                    CustomSheet.showBottomSheet(
                        content: SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: Column(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      ref
                                          .read(themeNotifierProvider.notifier)
                                          .toggleTheme(true);
                                    },
                                    child: const Text('Dark Mode')),
                                TextButton(
                                    onPressed: () {
                                      ref
                                          .read(themeNotifierProvider.notifier)
                                          .toggleTheme(false);
                                    },
                                    child: const Text('Light Mode')),
                              ],
                            )));
                  },
                  icon: const Icon(Icons.brightness_6),
                  label: const Text('Toggle Theme'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
                const Divider(),
                TextButton.icon(
                  onPressed: () async {
                    CustomAlertDialog.showAlertDialog(
                      onCancel: () {},
                      title: 'Log out ',
                      message: 'Are you sure you want to log out of the app?',
                      onConfirm: () async {
                        await ref
                            .read(userSharedPrefsProvider)
                            .deleteUserToken();
                        NavigateRoute.popAndPushRoute(LoginView());
                      },
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
