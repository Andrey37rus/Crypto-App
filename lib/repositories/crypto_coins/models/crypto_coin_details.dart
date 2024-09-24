// Импортируется файл models.dart, который содержит базовый класс CryptoCoin
// и другие связанные модели данных.
import 'package:crypto_coins_list/repositories/crypto_coins/models/models.dart';

//Класс CryptoCoinDetail наследуется от CryptoCoin. Это означает, что CryptoCoinDetail
// будет иметь все свойства и методы, определенные в CryptoCoin, и может добавлять
// свои собственные свойства и методы.

//Конструктор класса CryptoCoinDetail принимает семь обязательных параметров:
//super.name, super.priceInUSD, super.imageURL — эти параметры передаются в 
//конструктор базового класса CryptoCoin.
//toSymbol типа String — символ валюты, в которой указана цена.
//lastUpdate типа DateTime — время последнего обновления данных.
//hight24Hour типа double — максимальная цена за последние 24 часа.
//low24Hours типа double — минимальная цена за последние 24 часа.
//Использование const перед конструктором позволяет создавать неизменяемые (immutable) объекты,
// что может быть полезно для оптимизации и упрощения работы с состоянием.

//Четыре дополнительных свойства класса:
//toSymbol — символ валюты, в которой указана цена.
//lastUpdate — время последнего обновления данных.
//hight24Hour — максимальная цена за последние 24 часа.
//low24Hours — минимальная цена за последние 24 часа.
//Все свойства объявлены как final, что означает, что они не могут быть изменены после создания объекта.

//Метод props переопределяется для использования с пакетом equatable.
//super.props возвращает список свойств, определенных в базовом классе CryptoCoin.
//..addAll([...]) добавляет новые свойства
// (toSymbol, lastUpdate, hight24Hour, low24Hours) в список свойств базового класса.
//Это позволяет сравнивать объекты CryptoCoinDetail на основе всех свойств, включая те,
// которые определены в базовом классе и в дочернем классе.

class CryptoCoinDetail extends CryptoCoin {
  const CryptoCoinDetail({
    required super.name,
    required super.priceInUSD,
    required super.imageURL,
    required this.toSymbol,
    required this.lastUpdate,
    required this.hight24Hour,
    required this.low24Hours,
  });

  // TOSYMBOL
  final String toSymbol;

  // LASTUPDATE
  final DateTime lastUpdate;

  // HIGH24HOUR
  final double hight24Hour;

  // LOW24HOUR
  final double low24Hours;

  @override
  List<Object> get props => super.props
    ..addAll([
      toSymbol,
      lastUpdate,
      hight24Hour,
      low24Hours,
    ]);
}

