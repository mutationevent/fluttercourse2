import 'package:fluttercourceecommerce2/pages/HomePage.dart';
import 'package:fluttercourceecommerce2/pages/LoginPageComplete.dart';
import 'package:fluttercourceecommerce2/pages/OnBoardingPage.dart';
import 'package:fluttercourceecommerce2/pages/ProductDetailsPage.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: 'begin',
      path: '/',
      builder: (context, state) => OnBoardingPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPageComplete(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) => ProductDetailsPage(id: state.params['id']),
    ),
  ],
);
