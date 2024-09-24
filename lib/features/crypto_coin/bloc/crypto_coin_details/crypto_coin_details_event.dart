part of 'crypto_coin_details_bloc.dart';


// Абстрактный класс CryptoCoinDetailsEvent: Этот класс является базовым классом
// для всех событий, связанных с деталями криптовалюты. Он наследуется от Equatable,
// что позволяет сравнивать объекты этого класса на равенство без
// необходимости переопределения метода == и hashCode.
// Конструктор const CryptoCoinDetailsEvent(): Это константный конструктор,
// который создает неизменяемый объект.
// Метод props: Этот метод возвращает список свойств, которые будут использоваться
// для сравнения объектов на равенство.
// В данном случае, базовый класс не имеет никаких свойств, поэтому возвращается пустой список.
abstract class CryptoCoinDetailsEvent extends Equatable {
  const CryptoCoinDetailsEvent();

  @override
  List<Object> get props => [];
}


// Класс LoadCryptoCoinDetails: Этот класс представляет событие загрузки деталей криптовалюты.
// Он наследуется от CryptoCoinDetailsEvent.
// Конструктор const LoadCryptoCoinDetails({required this.currencyCode}): Это константный
// конструктор, который принимает обязательный параметр currencyCode и создает неизменяемый объект.
// Свойство currencyCode: Это свойство хранит код валюты, для которой нужно загрузить детали криптовалюты.
// Метод props: Этот метод возвращает список свойств, которые будут использоваться
// для сравнения объектов на равенство. 
// В данном случае, список содержит свойство currencyCode, которое добавляется
// к списку свойств базового класса с помощью оператора ..add().


// Метод props используется для определения свойств, которые будут использоваться
// при сравнении объектов на равенство. Вот как это работает: В базовом классе props
// возвращает пустой список, так как у него нет никаких свойств.

// В подклассе LoadCryptoCoinDetails метод props вызывает super.props, 
// чтобы получить список свойств базового класса, а затем добавляет свойство
// currencyCode с помощью оператора ..add(). Это означает, что список свойств теперь содержит currencyCode.
class LoadCryptoCoinDetails extends CryptoCoinDetailsEvent {
  const LoadCryptoCoinDetails({
    required this.currencyCode,
  });

  final String currencyCode;

  @override
  List<Object> get props => super.props..add(currencyCode);
}


