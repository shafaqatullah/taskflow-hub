import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final providers = await buildProviders();

  runApp(MultiProvider(providers: providers, child: const TaskFlowApp()));
}
