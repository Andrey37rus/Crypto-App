//Эта директива указывает, что данный файл является частью файла crypto_list_bloc.dart.
// Это позволяет разделить код на несколько файлов, но при этом сохранить их в одном логическом блоке.
part of 'crypto_list_bloc.dart';

//CryptoListState — это абстрактный класс, который наследуется от Equatable.
//Абстрактный класс служит базовым классом для всех состояний, связанных с списком криптовалют.
//Наследование от Equatable позволяет сравнивать объекты состояний на основе их свойств.
abstract class CryptoListState extends Equatable {}


//Класс CriptoListInitial наследуется от CryptoListState и представляет начальное состояние списка криптовалют.
//Метод props переопределяется для использования с пакетом equatable.
//props возвращает пустой список, так как начальное состояние не имеет свойств.
class CriptoListInitial extends CryptoListState {
  @override
  List<Object?> get props => [];
}

//Класс CryptoListLoading наследуется от CryptoListState и представляет состояние загрузки списка криптовалют.
//Метод props переопределяется для использования с пакетом equatable.
//props возвращает пустой список, так как состояние загрузки не имеет свойств.
class CryptoListLoading extends CryptoListState {
    @override
  List<Object?> get props => [];
}


//Класс CryptoListLoaded наследуется от CryptoListState и представляет состояние,
// когда список криптовалют успешно загружен.
//Конструктор класса принимает обязательный параметр coinsList типа List<CryptoCoin>.
//Свойство coinsList содержит список загруженных криптовалют.
//Метод props переопределяется для использования с пакетом equatable.
//props возвращает список, содержащий свойство coinsList.
class CryptoListLoaded extends CryptoListState {
  CryptoListLoaded({
    required this.coinsList,
  });

  final List<CryptoCoin> coinsList;

    @override
  List<Object?> get props => [coinsList];
}

//Класс CryptoListLoadingFailure наследуется от CryptoListState и представляет состояние,
// когда загрузка списка криптовалют завершилась неудачей.
//Конструктор класса принимает опциональный параметр exeption типа Object?.
//Свойство exeption содержит информацию об ошибке.
//Метод props переопределяется для использования с пакетом equatable.
//props возвращает список, содержащий свойство exeption.
class CryptoListLoadingFailure extends CryptoListState {
  CryptoListLoadingFailure({
    this.exeption,
  });

  final Object? exeption;

    @override
  List<Object?> get props => [exeption];
}
