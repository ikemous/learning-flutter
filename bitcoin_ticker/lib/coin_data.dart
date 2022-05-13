import 'package:bitcoin_ticker/secrets.dart';
import 'package:dio/dio.dart';

// https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC{Currency}
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  final String bareUrl =
      "https://apiv2.bitcoinaverage.com/indices/global/ticker/";

  Future<Map?> getCoinData({
    required String cryptoCurrency,
    required String selectedCurrency,
  }) async {
    Dio dio = Dio();
    dio.options.headers['x-ba-key'] = cryptoApiKey;
    Response response;
    try {
      response = await dio.get("$bareUrl$cryptoCurrency$selectedCurrency");
      Map coinData = response.data;
      return coinData;
    } catch (e) {
      print(e);
    }
    return null;
  }

  dynamic getAllCoinData({
    required String selectedCurrency,
  }) async {
    dynamic btcData = await getCoinData(
      cryptoCurrency: 'BTC',
      selectedCurrency: selectedCurrency,
    );
    dynamic ltcData = await getCoinData(
      cryptoCurrency: 'LTC',
      selectedCurrency: selectedCurrency,
    );
    dynamic ethData = await getCoinData(
      cryptoCurrency: 'ETH',
      selectedCurrency: selectedCurrency,
    );

    dynamic coinData = {
      'BTC': btcData,
      'LTC': ltcData,
      'ETH': ethData,
    };

    return coinData;
  }
}
