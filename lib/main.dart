import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  return runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  static const String title = 'GoRouter Routes';

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
        debugShowCheckedModeBanner: false,
      );

  final GoRouter _router = GoRouter(
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
    initialLocation: '/',
    routes: <GoRoute>[
      GoRoute(
        routes: <GoRoute>[
          GoRoute(
              path: 'Details/:id',
              builder: (BuildContext context, GoRouterState state) =>
                   DetailScreen(id:state.params['id']!)),
          GoRoute(
              path: 'Middle',
              pageBuilder: ( context, state) =>
                  MaterialPage(
                      fullscreenDialog: true,
                      child: Page3Screen(blog: state.extra.toString())),
          ),
          GoRoute(
              path: 'Profile',
              builder: (BuildContext context, GoRouterState state) =>
                  const Page4Screen()),
        ],
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(App.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                var id = Random().nextInt(100);
                context.push('/Details/$id');
                },
              child: const Text('Go to page 2'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                var blog = "cutie";
                context.go('/Middle', extra: blog);
              },
              child: const Text('Go to page 3'),
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  final Exception? error;
  const ErrorScreen({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Text(error.toString()),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String id;
  const DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text(router.location.toString().substring(1)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go back to homepage'),
            ),
          ],
        ),
      ),
    );
  }
}

class Page3Screen extends StatelessWidget {
  final String blog;
   const Page3Screen({Key? key, required this.blog,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(blog),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => context.push('/Profile'),
                child: const Text('Profile Page'))
          ],
        ),
      ),
    );
  }
}

class Page4Screen extends StatelessWidget {
  const Page4Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text(router.location.toString().substring(1)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Go to homepage'))
          ],
        ),
      ),
    );
  }
}
