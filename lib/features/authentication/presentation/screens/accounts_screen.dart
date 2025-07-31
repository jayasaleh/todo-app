import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/features/authentication/data/auth_repository.dart';
import 'package:to_do/features/task_management/presentation/widgets/task_dialog.dart';
import 'package:to_do/utils/app_styles.dart';
import 'package:to_do/utils/size_config.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);
    final currentUser = ref.watch(currentUserProvider)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: AppStyles.headingTextStyle.copyWith(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.getProportionateScreenWidth(20),
          vertical: SizeConfig.getProportionateScreenHeight(20),
        ),
        child: Column(
          children: [
            // Profile Section
            Container(
              padding: EdgeInsets.all(
                SizeConfig.getProportionateScreenWidth(20),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Colors.blue.shade100, width: 1.2),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blue.shade200, width: 2),
                    ),
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.blue.shade800,
                      size: 80,
                    ),
                  ),
                  SizedBox(height: SizeConfig.getProportionateScreenHeight(15)),
                  Text(
                    currentUser.email!,
                    style: AppStyles.titleTextStyle.copyWith(
                      fontSize: 18,
                      color: Colors.blue.shade900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.getProportionateScreenHeight(5)),
                  Text(
                    'Active User',
                    style: AppStyles.normalTextStyle.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

            // Logout Button
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                _showLogoutDialog(context, ref);
              },
              child: Container(
                alignment: Alignment.center,
                height: SizeConfig.getProportionateScreenHeight(50),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.white, size: 22),
                    SizedBox(width: 8),
                    Text(
                      'Log Out',
                      style: AppStyles.titleTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return TaskDialog(
          title: 'Log Out',
          content: Text(
            'Are you sure you want to logout?',
            style: AppStyles.normalTextStyle.copyWith(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: AppStyles.normalTextStyle.copyWith(
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: () {
                ref.read(authRepositoryProvider).signOut();
                Navigator.pop(context);
              },
              child: Text(
                'Log Out',
                style: AppStyles.normalTextStyle.copyWith(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
