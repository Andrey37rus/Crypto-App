//dart:async — импортируется для работы с асинхронными операциями.
//crypto_coins.dart — импортируется репозиторий AbstractCoinsRepository,
//который будет использоваться для получения данных о криптовалютах.
//equatable — импортируется для упрощения сравнения объектов.
//flutter_bloc — импортируется для работы с паттерном BLoC (Business Logic Component).
import 'dart:async';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//part директивы указывают, что классы CryptoListEvent и CryptoListState определены
// в отдельных файлах (crypto_list_event.dart и crypto_list_state.dart соответственно).
part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

//Класс CryptoListBloc наследуется от Bloc, который является базовым классом для реализации паттерна BLoC.
//Bloc<CryptoListEvent, CryptoListState> указывает, что CryptoListBloc будет обрабатывать 
//события типа CryptoListEvent и управлять состояниями типа CryptoListState.

//Конструктор класса CryptoListBloc принимает параметр coinsRepisitory типа AbstractCoinsRepository.
//super(CriptoListInitial()) вызывает конструктор базового класса Bloc и устанавливает
// начальное состояние CriptoListInitial

//on<LoadCryptoList> регистрирует обработчик для события LoadCryptoList.
//Внутри обработчика:
//try блок пытается выполнить асинхронную операцию.
//Если текущее состояние не является CryptoListLoaded, то вызывается emit(CryptoListLoading())
//для изменения состояния на CryptoListLoading.
//coinsRepisitory.getCoinsList() вызывает метод репозитория для получения списка криптовалют.
//Если операция успешна, вызывается emit(CryptoListLoaded(coinsList: coinsList)) для изменения
//состояния на CryptoListLoaded с полученным списком криптовалют.
//Если возникает ошибка, вызывается emit(CryptoListLoadingFailure(exeption: e)) для изменения
//состояния на CryptoListLoadingFailure с информацией об ошибке.
//finally блок гарантирует, что event.completer?.complete() будет вызван в любом случае,
// чтобы завершить асинхронную операцию.

//Свойство coinsRepisitory типа AbstractCoinsRepository используется для 
//взаимодействия с репозиторием данных о криптовалютах.

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this.coinsRepisitory) : super(CriptoListInitial()) {
    on<LoadCryptoList>((event, emit) async {
      try {
        if (state is! CryptoListLoaded) {
          emit(CryptoListLoading());
        }
        
        final coinsList = await coinsRepisitory.getCoinsList();
        emit(CryptoListLoaded(coinsList: coinsList));
      } catch (e) {
        emit(CryptoListLoadingFailure(exeption: e));
      }
      finally {
        event.completer?.complete();
      }
    });
  }

  final AbstractCoinsRepository coinsRepisitory;
}
