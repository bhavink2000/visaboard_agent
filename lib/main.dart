import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'Agent/App Helper/Providers/Authentication Provider/authentication_provider.dart';
import 'Agent/App Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import 'Agent/App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import 'Agent/App Helper/Routes/App Routes/app_routes.dart';
import 'Agent/App Helper/Routes/App Routes/app_routes_name.dart';

Future<void> main() async {
  Stripe.publishableKey = 'pk_test_51JNBMlSFCvuwyJp8biXA8yZWMQXHLmH1jm3VectCD1XICSSAtfGLuwJ4OP68P9nu7gm2rgFyx1LNkquBahRZJzn000UbHb1plO';
  runApp(MyApp());
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> AuthProvider()),
        ChangeNotifierProvider(create: (_)=> UserDataSession()),
        ChangeNotifierProvider(create: (_)=> AgentDrawerMenuProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutesName.splashscreen,
        onGenerateRoute: AppRoutes.generateRoute,
        theme: ThemeData(useMaterial3: false),
      ),
    );
  }
}
