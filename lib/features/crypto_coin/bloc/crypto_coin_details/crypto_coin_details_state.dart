part of 'crypto_coin_details_bloc.dart';


// Класс CryptoCoinDetailsState: Это базовый класс для всех состояний, связанных
// с деталями криптовалюты. Он наследуется от Equatable, что позволяет сравнивать
// объекты этого класса на равенство без необходимости переопределения метода == и hashCode.
//Конструктор const CryptoCoinDetailsState(): Это константный конструктор, который создает неизменяемый объект.
//Метод props: Этот метод возвращает список свойств, которые будут использоваться
// для сравнения объектов на равенство. В данном случае, базовый класс не имеет
// никаких свойств, поэтому возвращается пустой список.
class CryptoCoinDetailsState extends Equatable {
  const CryptoCoinDetailsState();

  @override
  List<Object?> get props => [];
}


//Класс CryptoCoinDetailsLoading: Этот класс представляет состояние, когда
// данные о криптовалюте загружаются. Он наследуется от CryptoCoinDetailsState.
//Конструктор const CryptoCoinDetailsLoading():
// Это константный конструктор, который создает неизменяемый объект.
class CryptoCoinDetailsLoading extends CryptoCoinDetailsState {
  const CryptoCoinDetailsLoading();
}


//Класс CryptoCoinDetailsLoaded: Этот класс представляет состояние, когда данные
// о криптовалюте успешно загружены. Он наследуется от CryptoCoinDetailsState.
//Конструктор const CryptoCoinDetailsLoaded(this.coin): Это константный конструктор,
// который принимает объект CryptoCoin и создает неизменяемый объект.
//Свойство coin: Это свойство хранит данные о криптовалюте.
//Метод props: Этот метод возвращает список свойств, которые будут использоваться
// для сравнения объектов на равенство. В данном случае, список содержит только свойство coin.
class CryptoCoinDetailsLoaded extends CryptoCoinDetailsState {
  const CryptoCoinDetailsLoaded(this.coinDetails);

  final CryptoCoinDetail coinDetails;
  @override
  List<Object?> get props => [coinDetails];
}

//Класс CryptoCoinDetailsLoadingFailure: Этот класс представляет состояние,
// когда загрузка данных о криптовалюте завершилась неудачей.
// Он наследуется от CryptoCoinDetailsState.

//Конструктор const CryptoCoinDetailsLoadingFailure(this.exception): Это константный
// конструктор, который принимает объект исключения и создает неизменяемый объект.
//Свойство exception: Это свойство хранит объект исключения, которое произошло
// во время загрузки данных.
//Метод props: Этот метод возвращает список свойств, которые будут использоваться
// для сравнения объектов на равенство. В данном случае, список содержит свойство
// exception, которое добавляется к списку свойств базового класса с помощью оператора ..add().
class CryptoCoinDetailsLoadingFailure extends CryptoCoinDetailsState {
  const CryptoCoinDetailsLoadingFailure(this.exception);

  final Object exception;

  @override
  List<Object?> get props => super.props..add(exception);
}


//Эти классы представляют различные состояния, которые могут возникнуть при загрузке
// данных о криптовалюте. Использование Equatable позволяет легко сравнивать эти
// состояния на равенство, что полезно, например, в контексте управления состоянием
// с помощью Bloc или Provider.