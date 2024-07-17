import 'package:flutter/material.dart';
import 'package:flutter_application_1/blocs/currency_bloc.dart';
import 'package:flutter_application_1/repositories/currency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/screens/currency_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CurrencyBloc(CurrencyRepository()),
        )
      ],
      child: MaterialApp(
        title: 'Currency Converter',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: CurrencyListScreen(),
      ),
    );
  }
}
