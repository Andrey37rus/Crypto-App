

//Репозиторий использует библиотеку Dio для выполнения HTTP-запросов к API и получения данных о криптовалютах. 


//Dio — это мощная HTTP-клиентская библиотека для Dart, которая используется для выполнения HTTP-запросов.
//crypto_coins.dart — это файл, содержащий модели данных и абстрактный 
//класс AbstractCoinsRepository, который определяет контракт для работы с данными о криптовалютах.
import 'package:dio/dio.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';


 //Методы getCoinsList и getCoinDetails позволяют получать как общие данные о
 // нескольких криптовалютах, так и детали о конкретной криптовалюте.

//Класс CryptoCoinsRepository реализует интерфейс AbstractCoinsRepository.
//В конструкторе класса требуется передать экземпляр Dio, который будет
// использоваться для выполнения HTTP-запросов.
class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({
    required this.dio,
  });

  final Dio dio;

  //Метод getCoinsList возвращает список объектов CryptoCoin.
 //Выполняется GET-запрос к API для получения данных о нескольких криптовалютах в USD.
 //Полученные данные представляют собой JSON-объект, который преобразуется в Map<String, dynamic>.
 //Извлекаются данные о цене и URL изображения для каждой криптовалюты.
 //Создаются объекты CryptoCoin и добавляются в список, который затем возвращается.

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,'
        'BNB,WBTC,YFI,CORE,WBETH,WEETH,PAXG,XAUT,TAO,BCH,XMR,CGO,LTC&tsyms=USD');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      // final price = usdData['PRICE'];
      final price =
          double.parse((usdData['PRICE'] as double).toStringAsFixed(2));
      final imageUrl = usdData['IMAGEURL'];
      return CryptoCoin(
        name: e.key,
        priceInUSD: price,
        imageURL: 'http://www.cryptocompare.com/$imageUrl',
      );
    }).toList();
    return cryptoCoinsList;
  }

  //Метод getCoinDetails возвращает детали о конкретной криптовалюте, заданной кодом валюты (currencyCode).
 //Выполняется GET-запрос к API для получения данных о конкретной криптовалюте в USD.
 //Извлекаются данные о цене, URL изображения, символе валюты, последнем обновлении,
 // максимальной и минимальной цене за последние 24 часа.
 //Создается объект CryptoCoinDetail с полученными данными и возвращается.

  @override
  Future<CryptoCoinDetail> getCoinDetails(String currencyCode) async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final price = double.parse((usdData['PRICE'] as double).toStringAsFixed(2));
    final imageUrl = usdData['IMAGEURL'];
    final toSymbol = usdData['TOSYMBOL'];
    final lastUpdate = usdData['LASTUPDATE'];
    final hight24Hour = double.parse((usdData['HIGH24HOUR'] as double).toStringAsFixed(2));
    final low24Hours = double.parse((usdData['LOW24HOUR'] as double).toStringAsFixed(2));

    return CryptoCoinDetail(
      name: currencyCode,
      priceInUSD: price,
      imageURL: 'https://www.cryptocompare.com/$imageUrl',
      toSymbol: toSymbol,
      lastUpdate: DateTime.fromMillisecondsSinceEpoch(lastUpdate),
      hight24Hour: hight24Hour,
      low24Hours: low24Hours,
      );
  }

}

