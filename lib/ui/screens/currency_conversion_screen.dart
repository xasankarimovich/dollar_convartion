import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/currency.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class CurrencyConversionScreen extends StatefulWidget {
  final Currency currency;

  const CurrencyConversionScreen({super.key, required this.currency});

  @override
  _CurrencyConversionScreenState createState() => _CurrencyConversionScreenState();
}

class _CurrencyConversionScreenState extends State<CurrencyConversionScreen> {
  final TextEditingController _controller = TextEditingController();
  double convertedAmount = 0.0;
  bool isUsdToCurrency = true;

  void _convertCurrency() {
    final amount = double.tryParse(_controller.text);
    if (amount != null) {
      setState(() {
        if (isUsdToCurrency) {
          convertedAmount = amount * widget.currency.rate;
        } else {
          convertedAmount = amount / widget.currency.rate;
        }
      });
    }
  }

  void _toggleConversion() {
    setState(() {
      isUsdToCurrency = !isUsdToCurrency;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Convert to ${widget.currency.name}')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: isUsdToCurrency ? 'Enter amount in USD' : 'Enter amount in ${widget.currency.name}',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertCurrency,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text(
              'Converted Amount:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 10),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Text(
                '$convertedAmount ${isUsdToCurrency ? widget.currency.name : 'USD'}',
                key: ValueKey<double>(convertedAmount),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleConversion,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text('Switch Conversion Direction'),
            ),
            const SizedBox(height: 20),
            FAProgressBar(
              currentValue: convertedAmount.toDouble(),
              displayText: isUsdToCurrency ? widget.currency.name : 'USD',
              size: 20,
              backgroundColor: Colors.cyan,
              progressColor: Colors.green,
              animatedDuration: const Duration(milliseconds: 500),
            ),
          ],
        ),
      ),
    );
  }
}
