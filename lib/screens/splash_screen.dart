import 'package:ct484_project/providers/auth_provider.dart';
import 'package:ct484_project/providers/cart_provider.dart';
import 'package:ct484_project/providers/user_provider.dart';
import 'package:ct484_project/screens/main_screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'auth_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final isLogin = await context.read<AuthProvider>().checkAuthState();

      if (isLogin) {
        await context.read<UserProvider>().getSingleUser();
        await context.read<CartProvider>().getCartData();
        Get.offAll(() => const MainScreens());
      } else {
        Get.offAll(() => AuthScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
