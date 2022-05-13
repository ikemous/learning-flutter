import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'dart:developer' as dev show log;

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key, required this.initialCoinData});
  final dynamic initialCoinData;

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  double btcPrice = 0;
  double ltcPrice = 0;
  double ethPrice = 0;

  void updateUI(dynamic coinData) {
    setState(() {
      if (coinData != null) {
        btcPrice = coinData['BTC']['ask'];
        ltcPrice = coinData['LTC']['ask'];
        ethPrice = coinData['ETH']['ask'];
        return;
      }
      btcPrice = 0;
      ltcPrice = 0;
      ethPrice = 0;
      btcPrice = 0;
      selectedCurrency = 'Error';
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.initialCoinData);
  }

  DropdownButton<String> getDropDownButton() {
    List<DropdownMenuItem<String>> items = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      items.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: items,
      onChanged: (value) async {
        dynamic coinData =
            await CoinData().getAllCoinData(selectedCurrency: value.toString());

        updateUI(coinData);
        setState(() {
          selectedCurrency = value.toString();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> items = [];
    for (String currency in currenciesList) {
      Text newItem = Text(currency);
      items.add(newItem);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {},
      children: items,
    );
  }

  Widget getPicker() {
    if (kIsWeb) {
      return getDropDownButton();
    } else if (Platform.isIOS) {
      return iOSPicker();
    } else {
      return getDropDownButton();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CryptoCoinDisplay(
                  cryptoCurrencyAltName: 'BTC',
                  btcPrice: btcPrice,
                  selectedCurrency: selectedCurrency,
                ),
                CryptoCoinDisplay(
                  cryptoCurrencyAltName: 'LTC',
                  btcPrice: ltcPrice,
                  selectedCurrency: selectedCurrency,
                ),
                CryptoCoinDisplay(
                  cryptoCurrencyAltName: 'ETH',
                  btcPrice: ethPrice,
                  selectedCurrency: selectedCurrency,
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          )
        ],
      ),
    );
  }
}

class CryptoCoinDisplay extends StatelessWidget {
  const CryptoCoinDisplay({
    Key? key,
    required this.btcPrice,
    required this.selectedCurrency,
    required this.cryptoCurrencyAltName,
  }) : super(key: key);

  final double btcPrice;
  final String selectedCurrency;
  final String cryptoCurrencyAltName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0.0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrencyAltName = $btcPrice $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
