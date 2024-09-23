import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin.dart';

abstract class AbstractCoinsRepisitory {
  Future<List<CryptoCoin>> getCoinsList();
}
