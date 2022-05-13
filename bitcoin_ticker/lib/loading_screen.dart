import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/price_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getCoinData() async {
    dynamic coinData = await CoinData().getAllCoinData(selectedCurrency: 'USD');
    // dynamic btcData = await CoinData().getCoinData(
    //   cryptoCurrency: 'BTC',
    //   selectedCurrency: 'USD',
    // );
    // dynamic ltcData = await CoinData().getCoinData(
    //   cryptoCurrency: 'LTC',
    //   selectedCurrency: 'USD',
    // );
    // dynamic ethData = await CoinData().getCoinData(
    //   cryptoCurrency: 'ETH',
    //   selectedCurrency: 'USD',
    // );

    // dynamic coinData = {
    //   'BTC': btcData,
    //   'LTC': ltcData,
    //   'ETH': ethData,
    // };

    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PriceScreen(initialCoinData: coinData),
      ),
    );
  }

  @override
  void initState() {
    getCoinData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: const Center(
        child: SpinKitDoubleBounce(
          color: Colors.blueGrey,
          size: 100.0,
        ),
      ),
    );
  }
}
