import 'package:flutter/material.dart';
import 'package:flutter_application_1/repositories/currency_repository.dart';
import 'package:flutter_application_1/ui/screens/currency_conversion_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../blocs/currency_bloc.dart';

class CurrencyListScreen extends StatelessWidget {
  const CurrencyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Currency Converter')),
      body: BlocProvider(
        create: (context) => CurrencyBloc(CurrencyRepository())..add(FetchCurrencies()),
        child: BlocBuilder<CurrencyBloc, CurrencyState>(
          builder: (context, state) {
            if (state is CurrencyLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CurrencyLoaded) {
              return AnimationLimiter(
                child: ListView.builder(
                  itemCount: state.currencies.length,
                  itemBuilder: (context, index) {
                    final currency = state.currencies[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: ListTile(
                            leading: Icon(Icons.monetization_on, color: Colors.green[700]),
                            title: Text(
                              currency.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Rate: ${currency.rate}',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios, color: Colors.green[700]),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CurrencyConversionScreen(currency: currency),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(child: Text('Failed to load currencies'));
            }
          },
        ),
      ),
    );
  }
}
