//dart:async — импортируется для работы с асинхронными операциями.
//crypto_list_bloc.dart — импортируется BLoC для управления состоянием списка криптовалют.
//crypto_coin_tile.dart — импортируется виджет для отображения информации о криптовалюте.
//crypto_coins.dart — импортируется репозиторий AbstractCoinsRepository.
//flutter/material.dart — импортируется для использования виджетов Material Design.
//flutter_bloc — импортируется для работы с паттерном BLoC.
//get_it — импортируется для внедрения зависимостей.

import 'dart:async';
import 'package:crypto_coins_list/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:crypto_coins_list/features/crypto_list/widgets/crypto_coin_tile.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

//Этот код реализует экран CryptoListScreen, который отображает список криптовалют.
// Он использует паттерн BLoC для управления состоянием и обновления UI в зависимости
// от текущего состояния. Экран поддерживает обновление списка при свайпе вниз и отображает
// индикатор загрузки или сообщение об ошибке в зависимости от результата загрузки данных.

//CryptoListScreen — это StatefulWidget, который создает состояние _CryptoListScreenState
class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

//_CryptoListScreenState — это состояние для CryptoListScreen.
//Создается экземпляр CryptoListBloc, который принимает репозиторий AbstractCoinsRepository
//через GetIt.I<AbstractCoinsRepository>().
class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cryptoListBloc = CryptoListBloc(
    GetIt.I<AbstractCoinsRepository>(),
  );

  //В методе initState добавляется событие LoadCryptoList в
  // _cryptoListBloc, чтобы начать загрузку списка криптовалют.
  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }

  //Метод build возвращает Scaffold, который содержит AppBar и RefreshIndicator.
 //AppBar имеет заголовок "Crypto".
 //RefreshIndicator позволяет обновлять список при свайпе вниз.
//onRefresh вызывается при обновлении и добавляет событие LoadCryptoList в _cryptoListBloc 
//с использованием Completer для отслеживания завершения операции.
//BlocBuilder используется для построения UI на основе текущего состояния CryptoListState.
//Если состояние CryptoListLoaded, отображается ListView.separated с элементами CryptoCoinTile.
//Если состояние CryptoListLoadingFailure, отображается сообщение об ошибке с кнопкой "Try again".
//В противном случае отображается CircularProgressIndicator для индикации загрузки.

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Crypto'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            final completer = Completer();
            _cryptoListBloc.add(LoadCryptoList(completer: completer));
            return completer.future;
          },
          child: BlocBuilder<CryptoListBloc, CryptoListState>(
            bloc: _cryptoListBloc,
            builder: (context, state) {
              if (state is CryptoListLoaded) {
                return ListView.separated(
                  padding: const EdgeInsets.only(top: 16),
                  itemCount: state.coinsList.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, i) {
                    final coin = state.coinsList[i];
                    return CryptoCoinTile(coin: coin);
                  },
                );
              }

              if (state is CryptoListLoadingFailure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Something went wrong",
                        style: theme.textTheme.headlineMedium,
                      ),
                      Text(
                        'Please try again later',
                        style:
                            theme.textTheme.labelSmall?.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 30),
                      TextButton(
                        onPressed: () {
                          _cryptoListBloc.add(LoadCryptoList());
                        },
                        child: const Text('Try again'),
                      )
                    ],
                  ),
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        )
        );
  }
}
