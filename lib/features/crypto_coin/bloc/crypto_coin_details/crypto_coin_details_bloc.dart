//crypto_coins.dart — импортируется репозиторий AbstractCoinsRepository,
// который будет использоваться для получения данных о криптовалюте.
//flutter_bloc — импортируется для работы с паттерном BLoC.
//equatable — импортируется для упрощения сравнения объектов.
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

//part директивы указывают, что классы CryptoCoinDetailsEvent и CryptoCoinDetailsState
//определены в отдельных файлах (crypto_coin_details_event.dart и crypto_coin_details_state.dart соответственно).
part 'crypto_coin_details_event.dart';
part 'crypto_coin_details_state.dart';

//Класс CryptoCoinDetailsBloc наследуется от Bloc, который является базовым
//классом для реализации паттерна BLoC.
//Bloc<CryptoCoinDetailsEvent, CryptoCoinDetailsState> указывает, что CryptoCoinDetailsBloc
//будет обрабатывать события типа CryptoCoinDetailsEvent и управлять состояниями типа CryptoCoinDetailsState.

//Конструктор класса CryptoCoinDetailsBloc принимает параметр coinsRepository типа AbstractCoinsRepository.
//super(const CryptoCoinDetailsState()) вызывает конструктор базового класса Bloc и устанавливает начальное состояние CryptoCoinDetailsState.
//on<LoadCryptoCoinDetails>(_load) регистрирует обработчик для события LoadCryptoCoinDetails,
// который вызывает метод _load.


class CryptoCoinDetailsBloc
    extends Bloc<CryptoCoinDetailsEvent, CryptoCoinDetailsState> {

  CryptoCoinDetailsBloc(this.coinsRepository)
      : super(const CryptoCoinDetailsState()) {
    on<LoadCryptoCoinDetails>(_load);

  }

  //Свойство coinsRepository типа AbstractCoinsRepository используется для
  // взаимодействия с репозиторием данных о криптовалютах.
  final AbstractCoinsRepository coinsRepository;

  //Метод _load является асинхронным и обрабатывает событие LoadCryptoCoinDetails.
 //Внутри метода:
 //try блок пытается выполнить асинхронную операцию.
 //Если текущее состояние не является CryptoCoinDetailsLoaded, то вызывается
 // emit(const CryptoCoinDetailsLoading()) для изменения состояния на CryptoCoinDetailsLoading.
 //coinsRepository.getCoinDetails(event.currencyCode) вызывает метод репозитория для получения 
 //детальной информации о криптовалюте.
 //Если операция успешна, вызывается emit(CryptoCoinDetailsLoaded(coinDetails)) для изменения
 // состояния на CryptoCoinDetailsLoaded с полученными деталями.
 //Если возникает ошибка, вызывается emit(CryptoCoinDetailsLoadingFailure(e)) для изменения
 // состояния на CryptoCoinDetailsLoadingFailure с информацией об ошибке.
  Future<void> _load(
    LoadCryptoCoinDetails event,
    Emitter<CryptoCoinDetailsState> emit,
  ) async {
    try {
      if (state is! CryptoCoinDetailsLoaded) {
        emit(const CryptoCoinDetailsLoading());
      }

      final coinDetails =
          await coinsRepository.getCoinDetails(event.currencyCode);

      emit(CryptoCoinDetailsLoaded(coinDetails));
    } catch (e) {
      emit(CryptoCoinDetailsLoadingFailure(e));
    }
  }
}

// Класс CryptoCoinDetailsBloc реализует паттерн BLoC для управления состоянием детальной
// информации о криптовалюте. Он обрабатывает событие LoadCryptoCoinDetails,
// которое инициирует загрузку данных о криптовалюте из репозитория.
// В зависимости от результата операции, BLoC изменяет состояние на CryptoCoinDetailsLoading,
// CryptoCoinDetailsLoaded или CryptoCoinDetailsLoadingFailure. 
// Это позволяет управлять состоянием приложения и обновлять пользовательский интерфейс в
// соответствии с текущим состоянием.